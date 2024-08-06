import 'package:flutter/material.dart';
import 'package:myapp/common.dart';
import 'package:myapp/model/task/task.dart';
import 'package:myapp/view/task/task_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My ToDo'),
        actions: [
          TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/new-task').then((newTask) {
                  setState(() {
                    if (newTask != null) {
                      GlobalData.myTasks.add(newTask as Task);
                    }
                  });
                });
              },
              label: const Text('Add'),
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
          itemCount: GlobalData.myTasks.length,
          itemBuilder: (context, index) {
            Task _currentTask = GlobalData.myTasks[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TaskDetailPage(currentTask: _currentTask)))
                    .then((value) {
                  setState(() {});
                });
              },
              title: Text(
                _currentTask.title,
                style: TextStyle(
                    decoration: _currentTask.isDone
                        ? TextDecoration.lineThrough
                        : null),
              ),
              subtitle: Text(_currentTask.description),
              trailing: Checkbox(
                value: _currentTask.isDone,
                onChanged: (value) {
                  setState(() {
                    _currentTask.isDone = value!;
                  });
                },
              ),
            );
          }),
    );
  }
}
