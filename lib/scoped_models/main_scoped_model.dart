import 'package:germinar/models/category_model.dart';
import 'package:germinar/models/habit_config_model.dart';
import 'package:germinar/models/habit_day_model.dart';
import 'package:germinar/models/habit_model.dart';
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
  List<HabitDay> userHabits = [];
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
        db.execute(
            "INSERT INTO habit VALUES (2, 'Carregar ecobags para às compras', 'Já parou pra pensar no tanto de sacolinha de plástico que vocẽ consome? Às vezes, sem perceber, colocamos um objeto minúsculo numa sacola de plástico. Será mesmo que tem necessidade disso?\n\nNo Brasil, cerca de 1,5 milhão de sacolas plásticas são distribuidas POR HORA. Onde acha que essas sacolas vão parar?\n\nRecuse as sacolinhas e leve sempre uma bolsa ou ecobag!', 1);");
        db.execute(
            "INSERT INTO habit VALUES (3, 'Comprar roupas usadas', 'Você sabia que no Brasil são produzidos, por ano, mais de 2 milhões de toneladas de tecido? Sendo que, atualmente, na fabricação de 1kg de tecido são utilizados 10 litros de água. Ou seja, a indústria têxtil brasileira consome, por ano, 20 bilhões de litros de água.\n\nAo doar roupas e comprar em brechós, você deixa de apoiar essa indústria, economizando água!', 1);");
        db.execute(
            "INSERT INTO habit VALUES (4, 'Reduzir tempo no banho', 'Pode não parecer, mas em 5 minutos de banho, um chuveiro comum pode chegar a gastar até 45 litros de água!\n\nReduzindo seu tempo no banho você poupa água e energia.', 2);");
        db.execute(
            "INSERT INTO habit VALUES (5, 'Organizar lavagem de roupas', 'Adote o costume de selecionar um ou dois dias da semana para lavar suas roupas! Se você vive sozinho, é possível lavá-las de duas em duas semanas.\n\nDesse jeito, você economiza até 125 litros de água por lavagem! Incentive sua família a adotar esse hábito sustentável!', 2);");
        db.execute(
            "INSERT INTO habit VALUES (6, 'Não consumir proteína animal', 'Você sabia que a produção de 1kg de carne boniva são utilizados aproximadamente 16 mil litros de água? A carne de porco também gasta muito, até 6 mil ltiros de água por kg!\n\nAlém disso, a pecurária é responsável por cerca de 80% do desmatamento no Brasil, tornando-a uma das maiores vilãs no gasto de água do país.\n\nNão consumindo carne, você ajuda a economizar muita água!', 2);");
        db.execute(
            "INSERT INTO habit VALUES (7, 'Usar transporte público', 'Estima-se que no Brasil exista cerca de um automóvel para cada 4 brasileiros, em um total de 207 milhões de habitantes. Isso pode ser notado pelos constantes engarrafamentos nas cidades.\n\nAo utilizar transporte público, você divide seu espaço no trânsito com mais pessoas, poluindo menos o ar com a emissão do dióxido de carbono.', 3);");
        db.execute(
            "INSERT INTO habit VALUES (8, 'Não consumir carne de vaca', 'Ao consumir carne de vaca, você incentiva a contínua criação de gado para o consumo humano. Qual o problema nisso?\n\nO sistema digestivo da vaca funciona como uma pequena fábrica de metano, um gás cerca de 20 vezes mais poluente que o dióxido de carbono, que é enviado para nossa atmosfera através do estrume e flatulências dela.\n\nAssim, deixando de consumir carne de vaca, você não contribui para essa emissão de gás poluente.', 3);");
        db.execute(
            "INSERT INTO habit VALUES (9, 'Não consumir laticínio', 'Ao consumir produtos com origem de leite de vaca ou ovelhas, você incentiva a contínua criação desses animais para gerar mais desses produtos. Qual o problema nisso?\n\nO sistema digestivo esses animais funciona como uma pequena fábrica de gás cerca de 20 vezes mais poluente que o dióxido de carbono, que é enviado pra nossa atmosfera através do estrume e flatulências desses animais.\n\nAssim, deixando de consumir laticínios, você não contribui para essa emissão de gás poluente.', 3);");
        db.execute(
            "INSERT INTO habit VALUES (10, 'Fazer compostagem', 'A compostagem é simples de ser feita e reduz em até 50% o lixo descartado por uma família, por exemplo.\n\nIsso faz com que o acúmulo de resíduos em aterros e lixões diminuam, e seu impacto ambiental também!', 4);");
        db.execute(
            "INSERT INTO habit VALUES (11, 'Separar o lixo por categoria', 'Separando o lixo, você facilita o processo de reciclagem. Desse modo, você reduz o impacto ambiental, que implica na diminuição da retirada de matéria prima da natureza, gera economia de água, reduz o despejo inadequado de lixo e auxilia n arenda de quem vive disso!', 4);");
        db.execute(
            "INSERT INTO habit VALUES (12, 'Reutilizar materiais', 'Não é porque uma coisa quebrou que ela precisa ir para o lixo. Aprenda a reutilizar materiais para criar coisas novas.\n\nO mundo do DIR (Faça você mesmo) está cheio de tutoriais que utilizam materiais reciclados para construir algo novo e útil. Aventure-se por esse mundo e crie maravilhosas novidades!', 4);");
        db.execute("INSERT INTO habit_days values (1, 0, 0, 0, 0, 1, 1, 0);");
        db.execute("INSERT INTO habit_days values (11, 0, 1, 0, 0, 0, 0, 0);");
        db.execute(
            "INSERT INTO habit_status VALUES (1, '2019-10-11T00:00:00.000', 1);");
        db.execute(
            "INSERT INTO habit_status VALUES (1, '2019-10-12T00:00:00.000', 0);");
      },
      version: 1,
    );
  }

  void initializeLists() async {
    await updateHabits();
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
    final List<Map<String, dynamic>> maps = await db.query(HabitDay.TABLE_NAME);
    userHabits = List.generate(maps.length, (i) {
      return HabitDay.fromMap(maps[i]);
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
    List<HabitDay> oldHabits = userHabits
        .where((h) => h.day.isBefore(DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .subtract(Duration(days: 30))))
        .toList();
    for (HabitDay h in oldHabits) {
      await db.delete(HabitDay.TABLE_NAME,
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
      for (HabitConfig habitDay in habitsDays) {
        if (habitDay.hasDay(dayCheck.weekday)) {
          List<Map<String, dynamic>> map = await db.query(HabitDay.TABLE_NAME,
              where: "habit_id=? AND day=?",
              whereArgs: [habitDay.habitId, dayCheck.toIso8601String()]);
          if (map.length == 0) {
            await db.execute(
                "INSERT INTO ${HabitDay.TABLE_NAME} VALUES (${habitDay.habitId}, '${dayCheck.toIso8601String()}', 0)");
          }
        }
      }
      dayCheck = dayCheck.add(Duration(days: 1));
    }
  }

  List<HabitDay> get todaysHabits {
    return userHabits
        .where((h) => h.day.isAtSameMomentAs(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)))
        .toList();
  }

  List<HabitDay> get nextHabits {
    return userHabits
        .where((h) => h.day.isAfter(DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .subtract(Duration(seconds: 1))))
        .toList(); // 23:59:59 do dia anterior
  }

  List<HabitDay> previousHabits() {
    return userHabits.where((h) => h.day.isBefore(DateTime.now())).toList();
  }

  bool userHasHabit(int habitId) {
    for (HabitConfig hs in userHabitsConfig) {
      if (hs.habitId == habitId) return true;
    }
    return false;
  }

  Habit getHabitForId(int habitId) {
    return habits.firstWhere((h) => h.id == habitId, orElse: () => null);
  }

  Future<bool> addHabitConfig(HabitConfig habitDays) async {
    if (userHasHabit(habitDays.habitId)) return false;

    final Database db = await _database;
    await db.insert(HabitConfig.TABLE_NAME, habitDays.toMap());
    userHabitsConfig.add(habitDays);
    await setupFutureHabits();
    await updateUserHabits();
    return true;
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
    for (HabitDay hs in nextHabits) {
      if (hs.habitId == habit.habitId) {
        db.delete(HabitDay.TABLE_NAME,
            where: "habit_id=? and day=?",
            whereArgs: [hs.habitId, hs.day.toIso8601String()]);
      }
    }
  }

  /// Usado quando o usuário marca ou desmarca um hábito como feito,
  Future<void> updateHabitDayStatus(HabitDay habit, bool done) async {
    habit.done = done;
    final Database db = await _database;
    await db.execute(
        "UPDATE ${HabitDay.TABLE_NAME} SET done=${done ? '1' : '0'} WHERE habit_id=${habit.habitId} and day='${habit.day.toIso8601String()}';");
    userHabits
        .removeWhere((h) => h.habitId == habit.habitId && h.day == habit.day);
    userHabits.add(habit);
    notifyListeners();
  }
}
