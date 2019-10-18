/// Salva qual hábito foi feito em qual dia pra manter histórico de hábitos
class HabitStatus {
  static const String TABLE_NAME = "habit_status";

  /// Chave primária: (habit_id, day)
  /// Mesmo id do habito que ele se refere.
  int habitId;
  DateTime day;

  /// Se o hábito foi feito ou não no dia previsto
  bool done;

  HabitStatus(this.habitId, this.day, {this.done = false});

  HabitStatus.fromMap(Map<String, dynamic> map) {
    habitId = map['habit_id'];
    day = DateTime.parse(map['day']);
    done = map['done'] == 1;
  }

  @override
  String toString() {
    return "habito $habitId, day $day, done $done";
  }
}
