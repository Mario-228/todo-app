import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/todoApp.dart';

import 'consts.dart';
void main()
{
   Bloc.observer = MyBlocObserver();
  runApp(const MyWidget());
}
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: todoApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}