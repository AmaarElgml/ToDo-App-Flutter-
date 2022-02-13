import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/entities/Task.dart';
import 'package:todo_app/domain/task_services.dart';
import 'package:todo_app/presentation/bloc/states.dart';
import 'package:todo_app/presentation/widgets/bottom_sheets.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  final String pageTitle = 'Tasks App';
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController titleController = TextEditingController();
  final TaskServices _services = TaskServices();
  List<Task> tasks = [];

  void getAllTasks() async {
    emit(AppGetDatabaseLoadingState());
    tasks = await _services.getAll();
    emit(AppGetDatabaseSuccessState());
  }

  void addTask(String name) async {
    await _services.insert(name);
    getAllTasks();
    emit(AppUpdateListState());
  }

  void updateTask(int id, int complete) async {
    await _services.update(id, complete);
    getAllTasks();
    emit(AppUpdateListState());
  }

  void deleteTask(int id) async {
    await _services.delete(id);
    getAllTasks();
    emit(AppUpdateListState());
  }

  void clearDB() async {
    await _services.clearDB();
    getAllTasks();
    emit(AppUpdateListState());
  }

  void onAddPressed() {
    if (isSheetShown) {
      if (titleController.text.trim().isNotEmpty) {
        addTask(titleController.text);
        titleController.clear();
        emit(AppAddedTaskPressedState());
      }
    } else {
      scaffoldKey.currentState!
          .showBottomSheet((context) => addTaskSheet(titleController),
              elevation: 8.0)
          .closed
          .then((value) {
        changeFABFunctionality(false);
      });
      changeFABFunctionality(true);
    }
  }

  bool isSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeFABFunctionality(bool isShown) {
    if (isShown)
      fabIcon = Icons.add;
    else
      fabIcon = Icons.edit;
    isSheetShown = isShown;
    emit(AppChangeBottomSheetState());
  }
}
