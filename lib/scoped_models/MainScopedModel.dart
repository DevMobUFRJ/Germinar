import 'package:germinar/models/category_model.dart';
import 'package:germinar/models/habit_config_model.dart';
import 'package:germinar/models/habit_model.dart';
import 'package:germinar/models/habit_status_model.dart';
import 'package:path/path.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';

class MainScopedModel extends Model {
  Future<Database> _database;

  /// Hábitos padrão do app
  List<Habit> habits = [];
  List<Category> categories = [];

  /// Hábitos que o usuário já configurou e fez ou tem pra fazer
  /// Inclui passados e futuros. Para pegar apenas histórico ou próximos,
  /// use os métodos adequados.
  List<HabitStatus> userHabits = [];
  List<HabitConfig> userHabitsConfig = [];

  MainScopedModel() {
    openDb().then((_) {
      initializeLists();
    });
  }

  Future openDb() async {
    _database = openDatabase(
      join(await getDatabasesPath(), 'habits.db'),
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE habit_status(habit_id INTEGER, day TEXT, done INTEGER);");
        db.execute(
            "CREATE TABLE habit(id INTEGER PRIMARY KEY, title TEXT, description TEXT, category_id INTEGER);");
        db.execute(
            "CREATE TABLE category(id INTEGER PRIMARY KEY, title TEXT);");
        db.execute(
            "CREATE TABLE habit_days(habit_id INTEGER PRIMARY KEY, monday INTEGER, tuesday INTEGER, wednesday INTEGER, thursday INTEGER, friday INTEGER, saturday INTEGER, sunday INTEGER);");
        db.execute(
            "INSERT INTO category VALUES (1, 'Consumo'), (2, 'Água'), (3, 'Ar'), (4, 'Reciclagem');");
        db.execute(
            "INSERT INTO habit VALUES (1, 'Carregar uma garrafa reutilizável', 'Diga não às garrafinhas de plástico. Estima-se que em 2016, mais de 480 bilhões de garras plásticas foram vendidas no mundo. Onde você acha que isso tudo foi parar?\n\nCarregue sua própria garrafa reutilizável de vidro ou aço inox, por exemplo, e não contribua para esse mercado poluente!', 1);");
        db.execute("INSERT INTO habit_days values (1, 0, 0, 0, 0, 1, 1, 0);");
        db.execute(
            "INSERT INTO habit_status VALUES (1, '2019-10-18T00:00:00.000', 0);");
        db.execute(
            "INSERT INTO habit_status VALUES (1, '2019-10-19T00:00:00.000', 0);");
        db.execute(
            "INSERT INTO habit_status VALUES (1, '2019-06-19T00:00:00.000', 1);");
      },
      version: 1,
    );
  }

  void initializeLists() async {
    updateHabits();
    updateCategories();
    updateUserHabitsConfig();
    await setupFutureHabits();
    await updateUserHabits();
    await cleanOldHabits();
    notifyListeners();
  }

  Future<void> updateHabits() async {
    final Database db = await _database;
    final List<Map<String, dynamic>> maps = await db.query(Habit.TABLE_NAME);
    habits = List.generate(maps.length, (i) {
      return Habit.fromMap(maps[i]);
    });
    notifyListeners();
  }

  Future<void> updateCategories() async {
    final Database db = await _database;
    final List<Map<String, dynamic>> maps = await db.query(Category.TABLE_NAME);
    categories = List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
    notifyListeners();
  }

  Future<void> updateUserHabits() async {
    final Database db = await _database;
    final List<Map<String, dynamic>> maps =
        await db.query(HabitStatus.TABLE_NAME);
    userHabits = List.generate(maps.length, (i) {
      return HabitStatus.fromMap(maps[i]);
    });
    notifyListeners();
  }

  Future<void> updateUserHabitsConfig() async {
    final Database db = await _database;
    final List<Map<String, dynamic>> maps =
        await db.query(HabitConfig.TABLE_NAME);
    userHabitsConfig = List.generate(maps.length, (i) {
      return HabitConfig.fromMap(maps[i]);
    });
    notifyListeners();
  }

  /// Remove hábitos concluídos há muito tempo
  Future<void> cleanOldHabits() async {
    final Database db = await _database;
    List<HabitStatus> oldHabits = userHabits
        .where((h) => h.day.isBefore(DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .subtract(Duration(days: 30))))
        .toList();
    for (HabitStatus h in oldHabits) {
      await db.delete(HabitStatus.TABLE_NAME,
          where: "habit_id=? and day=?",
          whereArgs: [h.habitId, h.day.toIso8601String()]);
    }
  }

  /// Insere hábitos das próximas semanas na tabela de habitos por dia
  Future<void> setupFutureHabits() async {
    final Database db = await _database;
    final List<Map<String, dynamic>> hts =
        await db.query(HabitConfig.TABLE_NAME);
    List<HabitConfig> habitsDays = List.generate(hts.length, (i) {
      return HabitConfig.fromMap(hts[i]);
    });
    DateTime dayCheck =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    for (int i = 1; i <= 30; i++) {
      dayCheck = dayCheck.add(Duration(days: 1));
      for (HabitConfig habitDay in habitsDays) {
        if (habitDay.hasDay(dayCheck.weekday)) {
          List<Map<String, dynamic>> map = await db.query(
              HabitStatus.TABLE_NAME,
              where: "habit_id=? AND day=?",
              whereArgs: [habitDay.habitId, dayCheck.toIso8601String()]);
          if (map.length == 0) {
            await db.execute(
                "INSERT INTO ${HabitStatus.TABLE_NAME} VALUES (${habitDay.habitId}, '${dayCheck.toIso8601String()}', 0)");
          }
        }
      }
    }
  }

  List<HabitStatus> nextHabits() {
    return userHabits
        .where((h) => h.day.isAfter(DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .subtract(Duration(seconds: 1))))
        .toList(); // 23:59:59 do dia anterior
  }

  List<HabitStatus> previousHabits() {
    return userHabits.where((h) => h.day.isBefore(DateTime.now())).toList();
  }

  bool hasHabit(int habitId) {
    for (HabitConfig hs in userHabitsConfig) {
      if (hs.habitId == habitId) return true;
    }
    return false;
  }

  Future<bool> addHabitConfig(HabitConfig habitDays) async {
    if (hasHabit(habitDays.habitId)) return false;

    final Database db = await _database;
    await db.insert(HabitConfig.TABLE_NAME, habitDays.toMap());
    userHabitsConfig.add(habitDays);
    await setupFutureHabits();
    await updateUserHabits();
  }

  void deleteHabitConfig(HabitConfig habit) async {
    final Database db = await _database;
    await db.delete(HabitConfig.TABLE_NAME,
        where: "habit_id=?", whereArgs: [habit.habitId]);
    updateUserHabitsConfig();
    _deleteFutureHabits(habit);
    notifyListeners();
  }

  void _deleteFutureHabits(HabitConfig habit) async {
    final Database db = await _database;
    for (HabitStatus hs in nextHabits()) {
      if (hs.habitId == habit.habitId) {
        db.delete(HabitStatus.TABLE_NAME,
            where: "habit_id=? and day=?",
            whereArgs: [hs.habitId, hs.day.toIso8601String()]);
      }
    }
  }

  Future<void> updateHabitStatus(HabitStatus habit, bool done) async {
    habit.done = done;
    final Database db = await _database;
    await db.execute(
        "UPDATE ${HabitStatus.TABLE_NAME} SET done=${done ? '1' : '0'} WHERE habit_id=${habit.habitId} and day='${habit.day.toIso8601String()}';");
    userHabits
        .removeWhere((h) => h.habitId == habit.habitId && h.day == habit.day);
    userHabits.add(habit);
    notifyListeners();
  }
}
