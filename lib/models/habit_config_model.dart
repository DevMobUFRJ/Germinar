/// Dias escolhidos pelo usuário para que determinado hábito seja executado
class HabitConfig {
  static const String TABLE_NAME = "habit_days";

  /// Mesmo ID do hábito a que ele se refere
  int habitId;
  bool monday, tuesday, wednesday, thursday, friday, saturday, sunday;

  HabitConfig(this.habitId, this.monday, this.tuesday, this.wednesday,
      this.thursday, this.friday, this.saturday, this.sunday);

  HabitConfig.fromMap(Map<String, dynamic> map) {
    habitId = map['habit_id'];
    monday = map['monday'] == 1;
    tuesday = map['tuesday'] == 1;
    wednesday = map['wednesday'] == 1;
    thursday = map['thursday'] == 1;
    friday = map['friday'] == 1;
    saturday = map['saturday'] == 1;
    sunday = map['sunday'] == 1;
  }

  Map<String, dynamic> toMap() => {
        'habit_id': habitId,
        'monday': monday ? 1 : 0,
        'tuesday': tuesday ? 1 : 0,
        'wednesday': wednesday ? 1 : 0,
        'thursday': thursday ? 1 : 0,
        'friday': friday ? 1 : 0,
        'saturday': saturday ? 1 : 0,
        'sunday': sunday ? 1 : 0
      };

  bool hasDay(int day) {
    switch (day) {
      case 1:
        return monday;
      case 2:
        return tuesday;
      case 3:
        return wednesday;
      case 4:
        return thursday;
      case 5:
        return friday;
      case 6:
        return saturday;
      case 7:
        return sunday;
      default:
        return false;
    }
  }

  @override
  String toString() {
    return "Habito $habitId - qui $thursday e sex $friday e sab $saturday";
  }
}
