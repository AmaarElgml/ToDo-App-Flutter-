import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/states.dart';
import 'package:todo_app/widgets/task_model.dart';

import '../../constants.dart';

class ArchivedTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archivedTasks;
        return tasks.length > 0
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  child: ListView(
                    children: [
                      SizedBox(height: 8),
                      ListView.separated(
                        itemBuilder: (context, index) =>
                            TaskModel(task: tasks[index]),
                        separatorBuilder: (context, index) => SizedBox(),
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tasks.length,
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              )
            : LayoutBuilder(
                builder: (ctx, constraints) => Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'No archived tasks yet!',
                        style: headLines2Style,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                          height: constraints.maxHeight * 0.6,
                          child: Image.asset(
                            'images/waiting.png',
                            fit: BoxFit.cover,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
