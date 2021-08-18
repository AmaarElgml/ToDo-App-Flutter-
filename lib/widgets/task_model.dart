import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/cubit/cubit.dart';

import '../constants.dart';

class TaskModel extends StatefulWidget {
  TaskModel({@required this.task});

  final Map task;

  @override
  _TaskModelState createState() => _TaskModelState();
}

class _TaskModelState extends State<TaskModel> {
  bool getDone() {
    if (widget.task['status'] == 'Done')
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionExtentRatio: 0.25,
      actionPane: SlidableDrawerActionPane(),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 12, left: 4, right: 4),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(30),
          ),
          child: IconSlideAction(
            caption: 'Delete',
            icon: Icons.delete,
            color: Colors.transparent,
            foregroundColor: Colors.white,
            onTap: () {
              AppCubit.get(context).deleteTask(id: widget.task['id']);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Deleted successfully'),
                duration: Duration(seconds: 1),
              ));
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 12, left: 4, right: 4),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(30),
          ),
          child: IconSlideAction(
            caption: 'Archive',
            icon: Icons.archive,
            color: Colors.transparent,
            foregroundColor: Colors.white,
            onTap: () {
              AppCubit.get(context)
                  .updateStatus(status: 'Archive', id: widget.task['id']);
            },
          ),
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        margin: EdgeInsets.only(bottom: 12.0, left: 8, right: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(4.0, 3.0), //(x,y)
              blurRadius: 3.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 30,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      widget.task['time'],
                      style: normalTextStyle.copyWith(
                          color: Colors.white, fontSize: 14.0),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.task['title'], style: normalTextStyle),
                    SizedBox(height: 6),
                    Text(
                      widget.task['date'],
                      style: normalTextStyle.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            CircularCheckBox(
              value: getDone(),
              inactiveColor: kPrimaryColor,
              activeColor: kPrimaryColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (x) {
                print('x = $x');
                if (x)
                  AppCubit.get(context)
                      .updateStatus(status: 'Done', id: widget.task['id']);
              },
            ),
          ],
        ),
      ),
    );
  }
}
