class Category {
  static const String TABLE_NAME = "category";

  int id;
  String title;

  Category(this.id, this.title);

  Category.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
  }
}
