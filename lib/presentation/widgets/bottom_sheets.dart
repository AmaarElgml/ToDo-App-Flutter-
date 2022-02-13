import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/style/app_theme.dart';
import 'custom_text_field.dart';

Widget addTaskSheet(controller) {
  return Container(
      color: Colors.indigo[100],
      padding: EdgeInsets.all(defSpacing * 1.25),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        CustomTextField(
            titleController: controller,
            hint: 'Task name',
            icon: Icons.title,
            type: TextInputType.text)
      ]));
}
