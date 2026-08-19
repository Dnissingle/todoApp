import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/pages/home_page.dart';

void main() async {
  // Ensure Flutter engine bindings are ready before running async init calls
  WidgetsFlutterBinding.ensureInitialized();

  // init Hive
  await Hive.initFlutter();

  // open a box
  await Hive.openBox('mybox'); // Added await keyword for explicit thread safety

  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        // FIX: Replaced removed primarySwatch with colorScheme to declare your theme color safely
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: Colors.teal,
        ),
        useMaterial3: true, // Opt-in to modern widget designs matching your updated slidable package
      ),
    );
  }
}
