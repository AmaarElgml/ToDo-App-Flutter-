import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/bloc/cubit.dart';
import 'package:todo_app/presentation/bloc/states.dart';
import 'package:todo_app/presentation/widgets/task_model.dart';
import 'package:todo_app/style/app_theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..getAllTasks(),
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (BuildContext context, state) {
          if (state is AppAddedTaskPressedState) Navigator.pop(context);
        }, builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
              key: cubit.scaffoldKey,
              appBar: AppBar(title: Text(cubit.pageTitle), actions: [
                TextButton(
                  child: Text('Clear', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      cubit.clearDB();
                    })
              ]),
              floatingActionButton: FloatingActionButton(
                  child: Icon(cubit.fabIcon),
                  onPressed: () {
                    cubit.onAddPressed();
                  }),
              body:
                  state is AppGetDatabaseLoadingState
                      ? Center(child: CircularProgressIndicator())
                      : cubit.tasks.length > 0
                          ? Container(
                              padding: EdgeInsets.all(defSpacing),
                              child: ListView.builder(
                                  itemCount: cubit.tasks.length,
                                  itemBuilder: (context, index) =>
                                      TaskModel(task: cubit.tasks[index])))
                          : noTasksAddedYet());
        }));
  }

  Widget noTasksAddedYet() {
    return LayoutBuilder(
        builder: (_, constraints) => Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Text('No tasks added yet!', style: headLines2Style),
                  SizedBox(height: defSpacing*2),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover, color: Colors.grey))
                ])));
  }
}
