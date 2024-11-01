import 'package:flutter/material.dart';
import 'package:tots_test/src/extensions/sizer.dart';

import 'colors.dart';

final themeData = ThemeData(
    primaryColor: color0D1111,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize: 16.w,
        color: color151914,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(8),
        backgroundColor: const WidgetStatePropertyAll(color0D1111),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        foregroundBuilder: (context, states, child) => Center(child: child),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(color0D1111),
        foregroundBuilder: (context, states, child) => SizedBox(
          child: Center(child: child),
        ),
      ),
    ));
