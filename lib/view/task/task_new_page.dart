import 'package:flutter/material.dart';
import 'package:myapp/model/task/task.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                  labelText: "Date",
                  border: OutlineInputBorder(),
                  suffix: IconButton(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDatePickerMode: DatePickerMode.day,
                                initialDate: dateController.text == ""
                                    ? DateTime.now()
                                    : DateTime.parse(dateController.text),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)))
                            .then((value) {
                          setState(() {
                            dateController.text = value.toString();
                          });
                        });
                      },
                      icon: Icon(Icons.calendar_month))),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.save),
        label: Text("Save"),
        onPressed: () {
          Task newTask = Task(
            title: titleController.text,
            description: descriptionController.text,
            date: DateTime.parse(dateController.text),
          );
          Navigator.pop(context, newTask);
        },
      ),
    );
  }
}
