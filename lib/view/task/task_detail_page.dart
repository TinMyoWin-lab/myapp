import 'package:flutter/material.dart';
import 'package:myapp/common.dart';
import 'package:myapp/model/task/task.dart';

class TaskDetailPage extends StatefulWidget {
  final Task currentTask;
  const TaskDetailPage({super.key, required this.currentTask});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool editMode = false;

  @override
  void initState() {
    titleController.text = widget.currentTask.title;
    descriptionController.text = widget.currentTask.description;
    dateController.text = widget.currentTask.date.toString();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Detail"),
        actions: [
          Visibility(
            visible: !editMode,
            child: IconButton(
              onPressed: () {
                setState(() {
                  editMode = !editMode;
                });
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          Visibility(
            visible: editMode,
            child: IconButton(
              onPressed: () {
                setState(() {
                  editMode = !editMode;
                });
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              readOnly: !editMode,
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
              readOnly: !editMode,
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
              readOnly: !editMode,
              controller: dateController,
              decoration: InputDecoration(
                  labelText: "Date",
                  border: OutlineInputBorder(),
                  suffix: IconButton(
                      onPressed: () {
                        showDatePicker(context: context, initialDatePickerMode: DatePickerMode.day,initialDate: dateController.text == "" ? DateTime.now() : DateTime.parse(dateController.text), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365))).then((value) {
                          setState(() {
                            dateController.text = value.toString();
                          });
                        });

                      }, icon: Icon(Icons.calendar_month))),
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: !editMode,
              child: ElevatedButton.icon(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Are you sure?"),
                              content: const Text(
                                  "Do you want to delete this task?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: const Text("No")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    child: const Text("Yes")),
                              ],
                            )).then((result) {
                      if (result) {
                        GlobalData.myTasks.remove(widget.currentTask);
                        Navigator.pop(context);
                      }
                    });
                  },
                  label: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Visibility(
                visible: editMode,
                child: ElevatedButton.icon(
                  onPressed: () {
                    widget.currentTask.title = titleController.text;
                    widget.currentTask.description = descriptionController.text;
                    widget.currentTask.date = DateTime.parse(dateController.text);
                    Navigator.pop(context);
                  },
                  label: const Text(
                    "Update",
                    style: TextStyle(color: Colors.green),
                  ),
                  icon: const Icon(
                    Icons.save,
                    color: Colors.green,
                  ),
                )),
          ],
        )
      ],
    );
  }
}
