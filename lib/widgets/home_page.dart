import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../Models.dart';

import 'popup_window.dart';
import 'task_list.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  int selectedList = 1;
  @override
  Widget build(BuildContext context) {


    final checkedTask = context.watch<TasksModel>().state.where((element) => element.checked).length;
    final percentage = checkedTask / context.watch<TasksModel>().state.length; // 0 - 1
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoList'),
        centerTitle: true,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PopupWindow();
                      },
                    ),
                  },
              child: const Text("New Task")),
          ElevatedButton(
              onPressed: () => {context.read<TasksModel>().removeSelected()},
              child: const Text("Remove Selected Tasks"))
        ],
      ),
      body: Column(
        children: [
          Consumer<TasksModel>(
            builder:(context, value, child) =>
                Column(children: [
              RadioListTile<int>(
                title: const Text("All Tasks"),
                value: 1,
                groupValue: selectedList,
                onChanged: (value) {
                selectedList = value!;


                  BlocProvider.of<TasksModel>(context).emitList( BlocProvider.of<TasksModel>(context).allTasks);
                },
              ),RadioListTile(

                title: const Text("Complete Tasks"),
                value: 2,
                groupValue: selectedList,
                onChanged: (value) {


                  selectedList=value!;
                  BlocProvider.of<TasksModel>(context).emitList(BlocProvider.of<TasksModel>(context).getCompletedTasks());
                },
              ),RadioListTile(
                title: const Text("Incompleted Tasks"),
                value: 3,
                groupValue: selectedList,
                onChanged: (value) {
                  selectedList = value!;
                  BlocProvider.of<TasksModel>(context).emitList(BlocProvider.of<TasksModel>(context).getIncompleteTasks());
                  // BlocProvider.of<TasksModel>(context).emit(tasks);
                },
              )
            ]),
          ),
          (context.read<TasksModel>().state.isEmpty)
              ? const Text("No Tasks")
              : LinearProgressIndicator(value: percentage),
          Expanded(
            child: TasksList(
              onTap: (int index) {
                context.read<TasksModel>().remove(index);
              },
              onChanged: (index, task) {
                context.read<TasksModel>().change(index);
              },
            ),
          )
        ],
      ),
    );
  }
}
