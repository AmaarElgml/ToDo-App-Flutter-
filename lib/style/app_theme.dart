import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// AppTheme
final ThemeData appTheme = ThemeData(
    primarySwatch: Colors.indigo,
    fontFamily: 'FredokaOne',
    appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent)));

// Colors
const defSpacing = 16.0;

// Styles
const TextStyle headLines2Style = TextStyle(color: Colors.grey, fontSize: 20);

InputBorder kInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(defSpacing * 1.25),
    borderSide: BorderSide(color: Colors.white));
