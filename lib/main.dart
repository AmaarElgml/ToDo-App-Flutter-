import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/style/app_theme.dart';
import 'presentation/pages/home_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, theme: appTheme, home: HomePage());
  }
}
