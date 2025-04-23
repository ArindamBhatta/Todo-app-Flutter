import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/todo.dart';
import 'package:todo/logic/todo_manager.dart';

class DetailsPage extends StatelessWidget {
  final String categoryTitle;
  final int taskIndex;
  final ElementTask task;

  const DetailsPage({
    super.key,
    required this.categoryTitle,
    required this.taskIndex,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Task Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text("Category: ${task.category}"),
            Text("Start Time: ${task.startTime}"),
            Text("Deadline: ${task.deadline}"),
            Text("Target Date: ${task.targetDate}"),
            Text("Expected Submit: ${task.expectedSubmitDate}"),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    taskProvider.toggleTaskDone(categoryTitle, taskIndex);
                  },
                  icon: Icon(task.isDone ? Icons.undo : Icons.check),
                  label: Text(
                    task.isDone ? 'Mark Incomplete' : 'Mark Complete',
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    taskProvider.deleteTask(categoryTitle, taskIndex);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
