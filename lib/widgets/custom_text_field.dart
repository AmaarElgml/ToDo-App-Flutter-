import 'package:flutter/material.dart';
import '../constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    @required this.titleController,
    @required this.hint,
    @required this.icon,
    @required this.type,
    this.onTap,
  });

  final TextEditingController titleController;
  final String hint;
  final IconData icon;
  final TextInputType type;
  final Function onTap;

  String _getErrorMessage() {
    switch (hint) {
      case 'Task Title':
        return 'Title must not be Empty!';
      case 'Task Date':
        return 'Date must not be Empty!';
      case 'Task Time':
        return 'Time must not be Empty!';
    }
    return 'Value is empty';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            offset: Offset(4.0, 3.0), //(x,y)
            blurRadius: 3.0,
          ),
        ],
      ),
      child: TextFormField(
        controller: titleController,
        validator: (String value) {
          if (value.isEmpty) return _getErrorMessage();
          return null;
        },
        keyboardType: type,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: kLightGray,
          ),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: kInputBorder,
          focusedBorder: kInputBorder,
          border: kInputBorder,
        ),
      ),
    );
  }
}
