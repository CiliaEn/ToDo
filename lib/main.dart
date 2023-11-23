import 'package:flutter/material.dart';
import 'pages/todo_page.dart';
import 'util/create_material_color.dart'; // Importera util.dart-filen
import 'package:timezone/data/latest.dart' as tz;
import 'add_todo.dart'; // Import the AddTodoPage file

void main() {
  tz.initializeTimeZones(); // Initialisera tidszoner
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo',
      home: TodoPage(), // Anpassa denna rad efter dina behov
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color.fromRGBO(253, 7, 7, 1)),
        // Alternativt, kan du använda Colors.deepPurple från 'main' grenen
      ),
    );
  }
}

// Lägg till MyHomePage klassen här om den behövs
