import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/task.dart';
class TasksModel extends Cubit<List<Task>> {
  List<Task> allTasks=[];
  List<Task>? completedTasks ;
  List<Task>? incompleteTasks ;

  TasksModel() : super([]);
  int c = 1;
  bool isCompleted = false;
  void add(Task newTask) {
    for (int i = 0; i < allTasks.length; i++) {
      if(allTasks[i].title==newTask.title){
        print("no");
        return;
      }
    }
    allTasks.add(newTask);
    emit(allTasks.toList());
  }

  void remove(int index) {
    for (int i = 0; i < allTasks.length; i++) {

      if (state[index].title == allTasks[i].title)
        allTasks.removeAt(i);
    }
    state.removeAt(index);
    emit(state.toList());
  }

  void removeSelected() {
    for (int i = 0; i < state.length; i++) {
      if (state[i].checked) {
        for (int j = 0; j < allTasks.length; j++) {
          if (state[i].title == allTasks[j].title) {
            allTasks.removeAt(j);
          }
        }
        state.removeAt(i);
        i--;
      }

    }
      emit(state.toList());

  }

  void change(int index) {

    final task = state[index];

    state[index] = task.copyWith(
      checked: !task.checked,
    );
    for (int i = 0; i < allTasks.length; i++){
      if (state[index].title == allTasks[i].title){
        allTasks[i]=task.copyWith(checked: !task.checked);
    }
    }
      emit(state.toList());
  }

  List<Task> getCompletedTasks(){
    completedTasks = allTasks.where((element) => (element.checked)).toList();
    return completedTasks!;
  }
  List<Task> getIncompleteTasks(){
    incompleteTasks = allTasks.where((element) => (!element.checked)).toList();
    return incompleteTasks!;
  }
  void emitList(List<Task> tasks){

    emit(tasks.toList());
  }



}

class WindowModel extends Cubit<bool> {
  WindowModel() : super(false);
  void change() {
    emit(!state);
  }
}
