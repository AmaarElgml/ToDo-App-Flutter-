import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/domain/entities/Task.dart';
import 'package:todo_app/presentation/bloc/cubit.dart';

class TaskModel extends StatelessWidget {
  TaskModel({required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: ValueKey(0),
        startActionPane: ActionPane(
            motion: ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              SlidableAction(
                  label: 'Delete',
                  backgroundColor: Colors.indigo,
                  icon: Icons.delete,
                  foregroundColor: Colors.white,
                  onPressed: (BuildContext context) {
                    AppCubit.get(context).deleteTask(task.id);
                  })
            ]),
        child: Card(
          elevation: 8,
          child: ListTile(
              title: Text(task.name),
              leading: Checkbox(
                  value: task.complete == 1,
                  onChanged: (value) {
                    AppCubit.get(context).updateTask(task.id, value! ? 1 : 0);
                  })),
        ));
  }
}
