class Habit {
  static const String TABLE_NAME = "habit";

  int id;
  String title;
  String description;
  int categoryId;

  Habit(this.id, this.title, this.description, this.categoryId);

  Habit.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    categoryId = map['category_id'];
  }
}
