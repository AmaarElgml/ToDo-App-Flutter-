import 'package:flutter/material.dart';
import 'package:todo_app/style/app_theme.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    required this.hint,
    required this.icon,
    required this.titleController,
    this.type,
    this.onTap,
  });

  final String hint;
  final IconData icon;
  final TextEditingController titleController;
  final TextInputType? type;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defSpacing * 1.25),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  offset: Offset(4.0, 3.0), //(x,y)
                  blurRadius: 3.0)
            ]),
        child: TextFormField(
            controller: titleController,
            keyboardType: type ?? TextInputType.text,
            onTap: () {
              onTap?.call();
            },
            decoration: InputDecoration(
                hintText: hint,
                prefixIcon: Icon(icon),
                fillColor: Colors.white,
                filled: true)));
  }
}
