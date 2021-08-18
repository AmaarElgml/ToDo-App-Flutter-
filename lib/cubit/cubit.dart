import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/cubit/states.dart';
import 'package:todo_app/screens/archived_tasks/archived_tasks_page.dart';
import 'package:todo_app/screens/done_tasks/done_tasks_page.dart';
import 'package:todo_app/screens/home_tasks/home_tasks_page.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> titles = [
    'ToDo',
    'Done Tasks',
    'Archived Tasks',
  ];

  List<Widget> pages = [
    HomeTasksPage(),
    DoneTasksPage(),
    ArchivedTasksPage(),
  ];

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('Database Created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then(
          (value) {
            print('Table Created');
          },
        ).catchError(
          (error) {
            print('Error on create DB: ${error.toString()}');
          },
        );
      },
      onOpen: (database) {
        getDataFromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    @required String title,
    @required String date,
    @required String time,
  }) async {
    await database.transaction(
      (txn) {
        txn
            .rawInsert(
                'INSERT INTO tasks (title, date, time, status) VALUES("$title", "$date", "$time", "New")')
            .then(
          (value) {
            print('$value Inserted Successfully');
            emit(AppInsertToDatabaseState());
            getDataFromDatabase(database);
          },
        ).catchError(
          (error) {
            print('Error on Insert to DB: ${error.toString()}');
          },
        );
        return null;
      },
    );
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'New')
          newTasks.add(element);
        else if (element['status'] == 'Done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateStatus({@required status, @required int id}) {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseLoadingState());
    });
  }

  void deleteTask({@required int id}) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseLoadingState());
    });
  }

  bool isSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState(
      {@required bool isShow, @required IconData icon}) {
    isSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
