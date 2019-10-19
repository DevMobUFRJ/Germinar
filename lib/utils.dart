class Utils {
  static String dateStringForDay(DateTime date) {
    return weekdayAsString(date.weekday) +
        ", " +
        (date.day < 10 ? '0' : '') +
        date.day.toString() +
        '/' +
        (date.month < 10 ? '0' : '') +
        date.month.toString();
  }

  static String weekdayAsString(int weekday) {
    switch (weekday) {
      case 1:
        return "Segunda";
      case 2:
        return "Terça";
      case 3:
        return "Quarta";
      case 4:
        return "Quinta";
      case 5:
        return "Sexta";
      case 6:
        return "Sábado";
      case 7:
        return "Domingo";
      default:
        return "Dia";
    }
  }
}
