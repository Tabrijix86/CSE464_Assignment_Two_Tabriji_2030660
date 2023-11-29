import 'package:flutter/material.dart';

import 'Task.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Task> _tasks = [];
  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[300],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddTaskScreen(
                  onAddTask: (newTask) {
                    setState(() {
                      _tasks.add(Task(name: newTask));
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage("assets/images/Tabriji-Photo.jpeg"),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Tabriji Islam",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  "tabrijiummi@gmail.com",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  "My Tasks",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "${_tasks.length - count} Task(s) to be Completed",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              // color: Colors.white,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),

              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_tasks[index].name,
                        style: _tasks[index].isDone == true
                            ? const TextStyle(
                                decoration: TextDecoration.lineThrough)
                            : const TextStyle()),
                    trailing: Checkbox(
                      value: _tasks[index].isDone,
                      onChanged: (value) {
                        setState(
                          () {
                            _tasks[index].isDone = value!;

                            count = 0;
                            for (var task in _tasks) {
                              if (task.isDone) {
                                count = count + 1;
                              }
                            }
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
