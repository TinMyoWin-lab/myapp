
class Task {
  String id = DateTime.now().toString();
  String title;
  String description;
  bool isDone = false;
  DateTime date;

  Task({
    required this.title,
    required this.description,
    required this.date,
  });
}
