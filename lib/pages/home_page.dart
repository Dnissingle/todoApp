import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/util/dialog_box.dart';
import 'package:todo/util/todo_tile.dart';

import '../data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  final _controller = TextEditingController();

  // NEW: Controller specifically for handling editing tasks
  final _editController = TextEditingController();

  TodoDatabase db = TodoDatabase();

  //first time ever opening the app
  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  //create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // NEW: Save edited task title
  void saveEditedTask(int index) {
    setState(() {
      db.toDoList[index][0] = _editController.text;
      _editController.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // NEW: Open dialog pre-filled with the current task name
  void editTask(int index) {
    _editController.text = db.toDoList[index][0]; // Fill field with old name
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _editController,
          onSave: () => saveEditedTask(index),
          onCancel: () {
            _editController.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: const Text("To Do"),
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return TodoTile(
                taskName: db.toDoList[index][0],
                taskCompleted: db.toDoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),
                // NEW: Pass the edit function down to your Slidable Tile
                editFunction: (context) => editTask(index),
              );
            }
        )
    );
  }
}
