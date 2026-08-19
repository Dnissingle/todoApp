

import 'package:hive_flutter/adapters.dart';

class TodoDatabase {
  List toDoList = [
  ];

  //reference box
  final _myBox = Hive.box('mybox');

  //first time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Do homework", false],
    ];
  }


    //load data from database
    void loadData(){
      toDoList = _myBox.get("TODOLIST");
    }

    // update the database
    void updateDatabase(){
      _myBox.put("TODOLIST", toDoList);
    }}




