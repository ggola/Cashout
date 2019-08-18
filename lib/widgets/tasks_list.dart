import 'package:flutter/material.dart';
import 'package:todoey_flutter/widgets/tasks_tile.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/persistent_storage.dart';

TodoProvider todoProvider = TodoProvider();

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskList>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemCount: taskData.taskCount,
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
              taskTitle: task.name,
              isChecked: task.isDone,
              onLongPressed: () async {
                int id = task.id;
                bool isDone = task.isDone;
                taskData.removeTask(task);
                if (!isDone) {
                  taskData.updateActiveTasks(checkBoxState: true);
                }
                await todoProvider.delete(id);
              },
              onChanged: (bool checkBoxState) async {
                taskData.updateActiveTasks(checkBoxState: checkBoxState);
                taskData.updateToggleDone(task);
                await todoProvider.update(task);
              },
            );
          },
        );
      },
    );
  }
}
