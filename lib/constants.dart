import 'package:flutter/material.dart';

// Colors
const Color kLightGray = Color(0xFFD9DFF8);
const Color kLightGray2 = Color(0xFFDCDCDC);
const Color kDarkGray = Color(0xFF757575);
const Color kPrimaryColor = Color(0xFF076AFF);
const Color kPrimaryDarkColor = Color(0xFF0E1F55);

// Styles
const TextStyle titleStyle = TextStyle(
  color: Colors.black87,
  fontSize: 24,
  fontWeight: FontWeight.w300,
  fontFamily: 'FredokaOne',
);

const TextStyle headLinesStyle = TextStyle(
  color: kDarkGray,
  fontSize: 26,
  fontFamily: 'FredokaOne',
);

const TextStyle headLines2Style = TextStyle(
  color: Colors.grey,
  fontSize: 20,
  fontFamily: 'FredokaOne',
);

const TextStyle normalTextStyle = TextStyle(
  color: Colors.black87,
  fontSize: 18,
);

InputBorder kInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(20),
  borderSide: BorderSide(
    color: Colors.white,
  ),
);
