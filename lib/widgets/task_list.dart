
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models.dart';
import 'task.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.onChanged,
    required this.onTap,
  });

  final void Function(int, Task) onChanged;
  final void Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TasksModel>().state;

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return InkWell(
          onLongPress: () => onTap(index),
          child: CheckboxListTile(
            title: Text(task.title),
            value: task.checked,
            onChanged: (value) =>
                onChanged(index, task), //onChanged(index, task),
          ),
        );
      },
    );
  }
}


