import 'package:flutter/material.dart';
import 'package:test_sm/src/helpers/NavHelper.dart';
import 'package:test_sm/src/views/auth/SignupScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavHelper.navigatorKey,
      home: SignupScreen(),
    );
  }
}
