import 'package:myapp/model/task/task.dart';


class GlobalData{

static List<Task> myTasks = [
  Task(
      title: "Task 1",
      description: "description 1",
      date: DateTime.now()),
  Task(
      title: "Task 2",
      description: "description 2",
      date: DateTime.now()),
  Task(
      title: "Task 3",
      description: "description 3",
      date: DateTime.now()),
  Task(
      title: "Task 4",
      description: "description 4",
      date: DateTime.now())
];

}

