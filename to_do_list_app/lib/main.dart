import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_app/controller/todo_provider.dart';
import 'package:to_do_list_app/view/screens/login_screen.dart';
import 'package:to_do_list_app/view/widgets/theme.dart';

void main() {
  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(

        home: const LoginPage(),
        theme: AppTheme.lightTheme, 
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}