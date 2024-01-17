import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../Models.dart';
import 'task.dart';

class PopupWindow extends StatelessWidget {
  final TextEditingController textCont = TextEditingController();

  PopupWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add new task"),
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.15,
        child: Column(
          children: [
            TextField(
              controller: textCont,
            ),
            Consumer<WindowModel>(
              builder: (context, value, child) => CheckboxListTile(
                title: const Text("Completed?"),
                value: BlocProvider.of<WindowModel>(context).state,
                onChanged: (value) {
                  BlocProvider.of<WindowModel>(context).change();
                },
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            if (BlocProvider.of<TasksModel>(context)
                .allTasks
                .where((element) => element.title == textCont.text)
                .isEmpty) {
              context.read<TasksModel>().add(Task(
                  title: textCont.text,
                  checked: BlocProvider.of<WindowModel>(context).state));
              Navigator.pop(context);
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                      "Oops, You cannot add this task because it is already in the task list"),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK"),
                    )
                  ],
                ),
              );
            }
          },
          child: const Text("add"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("cancel"),
        ),
      ],
    );
  }
}
