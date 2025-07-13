import 'package:flutter/material.dart';

class HomeScreenViewmodel extends ChangeNotifier {
  late final BuildContext context;

  init(BuildContext context) {
    this.context = context;
    notifyListeners();
  }
}
