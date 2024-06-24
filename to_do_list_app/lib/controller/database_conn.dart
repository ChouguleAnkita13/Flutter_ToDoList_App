import 'dart:developer';

import 'package:to_do_list_app/model/todo_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

dynamic database;

/// Establishes a connection to the database and creates the table if it doesn't exist.
Future<void> dbConnection() async {
  try {
    database = openDatabase(
      join(await getDatabasesPath(), "toDB13.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE ToDoTask(
          taskId INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          date DATE,
          isComplete BOOL
        )''');
      },
    );
  } catch (e) {
    log("Error establishing database connection: $e");
  }
}

/// Inserts a task into the database.
Future<void> insertTask(ToDoListModel obj) async {
  try {
    final localDB = await database;
    await localDB.insert('ToDoTask', obj.todoTaskMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  } catch (e) {
    log("Error inserting task: $e");
  }
}

/// Fetches all tasks from the database.
Future<List<ToDoListModel>> getAllTask() async {
  try {
    final localDB = await database;
    List<Map<String, dynamic>> taskList = await localDB.query('ToDoTask');
    return List.generate(taskList.length, (idx) {
      return ToDoListModel(
        taskId: taskList[idx]['taskId'],
        title: taskList[idx]['title'],
        description: taskList[idx]['description'],
        date: taskList[idx]['date'],
        isComplete: taskList[idx]['isComplete'] == 1,
      );
    });
  } catch (e) {
    log("Error fetching tasks: $e");
    return [];
  }
}

/// Deletes a task from the database.
Future<void> deleteTask(ToDoListModel obj) async {
  try {
    final localDB = await database;
    await localDB
        .delete('ToDoTask', where: 'taskId=?', whereArgs: [obj.taskId]);
  } catch (e) {
    log("Error deleting task: $e");
  }
}

/// Updates a task in the database.
Future<void> updateTask(ToDoListModel obj) async {
  try {
    final localDB = await database;
    await localDB.update('ToDoTask', obj.todoTaskMap(),
        where: 'taskId=?', whereArgs: [obj.taskId]);
  } catch (e) {
    log("Error updating task: $e");
  }
}
