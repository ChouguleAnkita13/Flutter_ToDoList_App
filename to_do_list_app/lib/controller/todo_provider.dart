import 'package:flutter/material.dart';
import 'package:to_do_list_app/controller/database_conn.dart';
import 'package:to_do_list_app/model/todo_model.dart';

/// A provider class for managing the state and operations of a to-do list.
class TodoProvider extends ChangeNotifier {
  /// The list of to-do items.
  List<ToDoListModel> _todoList = [];

  /// A getter to access the list of to-do items.
  List<ToDoListModel> get todoList => _todoList;

  /// Constructor that initializes the provider by connecting to the database and fetching tasks.
  TodoProvider() {
    dbConnection();
    _fetchTasks();
  }

  /// Fetches the tasks from the database and updates the list.
  Future<void> _fetchTasks() async {
    _todoList = await getAllTask();
    notifyListeners();
  }

  /// Adds a new task to the database and updates the list.
 
  Future<void> addTask(ToDoListModel task) async {
    await insertTask(task);
    _fetchTasks();
    notifyListeners();
  }

  /// Updates an existing task in the database and updates the list.
 
  Future<void> updateToDoTask(ToDoListModel task) async {
    await updateTask(task);
    _fetchTasks();
    notifyListeners();
  }

  /// Deletes a task from the database and updates the list.

  Future<void> deleteToDoTask(ToDoListModel task) async {
    await deleteTask(task);
    _fetchTasks();
    notifyListeners();
  }

  /// Toggles the completion status of a task and updates the list.
  ///
  /// [task] is the task whose completion status is to be toggled.
  void toggleTaskCompletion(ToDoListModel task) {
    final index = _todoList.indexOf(task);
    _todoList[index].isComplete = !_todoList[index].isComplete;
    notifyListeners();
  }
}
