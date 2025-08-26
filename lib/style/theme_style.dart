import 'package:flutter/material.dart';
import 'package:remind_task/style/text_style.dart';

import 'color_style.dart';

ThemeData themeStyle(BuildContext context) => ThemeData(
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: false,
  inputDecorationTheme: _inputDecorationTheme(context),
);

InputDecorationTheme _inputDecorationTheme(BuildContext context) =>
    InputDecorationTheme(
      hintStyle: poppins(
        color: Colors.black38,
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
      ),
      errorStyle: poppins(
        color: Colors.red,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      ),
      helperMaxLines: 1,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: ColorsStyle.oatmealModif, width: 1.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: ColorsStyle.oatmealModif, width: 1.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: ColorsStyle.oatmealModif, width: 1.0),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.red, width: 1.0),
      ),
      filled: true,
      fillColor: Colors.white,
    );
