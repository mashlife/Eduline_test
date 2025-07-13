import 'package:flutter/material.dart';
import 'package:test_sm/src/constants/Keys.dart';
import 'package:test_sm/src/helpers/NavHelper.dart';
import 'package:test_sm/src/views/language/LanguageScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavHelper.navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,

      home: LanguageScreen(),
    );
  }
}
