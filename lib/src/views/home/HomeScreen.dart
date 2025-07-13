import 'package:flutter/material.dart';
import 'package:test_sm/src/views/home/HomeScreenViewModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeScreenViewmodel _homeViewmodel;

  @override
  void initState() {
    super.initState();
    _homeViewmodel = HomeScreenViewmodel();
    _homeViewmodel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
