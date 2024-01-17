import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/widgets/home_page.dart';

import 'Models.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(
        create: (context) => TasksModel()),
      BlocProvider(create: (context) => WindowModel(),)],
        child: MaterialApp(
          home: HomePage(),
        ),
      );
   
  }
}
