import 'package:flutter/material.dart';
import 'package:my_flutter_todo_list/routes.dart';
import 'package:my_flutter_todo_list/screens/home_screen.dart';
import 'package:my_flutter_todo_list/screens/add_edit_screen.dart';
import 'models.dart';

class TodoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoAppState();
}

class TodoAppState extends State<TodoApp> {
  AppState appState = AppState.loading();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      routes: {
        TodoAppRoutes.home: (context) {
          return HomeScreen(
            appState: appState,
            addTodo: addTodo,
            updateTodo: updateTodo,
            removeTodo: removeTodo,
            toggleAll: toggleAll,
            clearCompleted: clearCompleted,
          );
        },
        TodoAppRoutes.addTodo: (context) {
          return AddEditScreen(
            addTodo: addTodo,
            updateTodo: updateTodo,
          );
        },
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _genereteTodo().then((todos) {
      setState(() {
        appState = AppState(todos: todos);
      });
    }).catchError((err) {
      setState(() {
        appState.isLoading = false;
      });
    });
    ;
  }

  updateTodo(Todo todo, {bool complite, String id, String note, String task}) {
    setState(() {
      todo.complete = complite ?? todo.complete;
      todo.id = id ?? todo.id;
      todo.note = note ?? todo.note;
      todo.task = task ?? todo.task;
    });
  }

  removeTodo(Todo todo) {
    setState(() {
      appState.todos.remove(todo);
    });
  }

  addTodo(Todo todo) {
    setState(() {
      appState.todos.add(todo);
    });
  }

  Future<List<Todo>> _genereteTodo() {
    return Future<List<Todo>>.delayed(Duration(seconds: 3), () {
      var todos = <Todo>[];
      for (var i = 1; i <= 5; i++)
        todos.add(Todo("Task # ${i}", complete: true, note: "note ${i}"));
      return todos;
    });
  }

  toggleAll() {
    setState(() {
      appState.toggleAll();
    });
  }

  clearCompleted() {
    setState(() {
      appState.clearCompleted();
    });
  }
}
