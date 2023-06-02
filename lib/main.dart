import 'package:flutter/material.dart';
import './routes/addStudentScreen.dart';
import './routes/addTeacherScreen.dart';
import './routes/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Single Page App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/add_student': (context) => AddStudentScreen(),
        '/add_teacher': (context) => AddTeacherScreen(),
      },
    );
  }
}
