import 'package:flutter/material.dart';
import 'package:my_flutter_todo_list/models.dart';

class AddEditScreen extends StatelessWidget {
  static final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState> taskkey = GlobalKey<FormFieldState>();
  static final GlobalKey<FormFieldState> notekey = GlobalKey<FormFieldState>();

  final Todo todo;
  final TodoAdder addTodo;
  final TodoUpdater updateTodo;

  const AddEditScreen(
      {this.todo, @required this.addTodo, @required this.updateTodo, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Todo" : "Save changes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                key: taskkey,
                initialValue: todo != null ? todo.task : '',
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(hintText: "What needs to be done?"),
                validator: (val) =>
                    val.trim().isEmpty ? "Please enter some text" : null,
              ),
              TextFormField(
                key: notekey,
                initialValue: todo != null ? todo.note : '',
                maxLines: 10,
                style: Theme.of(context).textTheme.subhead,
                decoration: InputDecoration(
                  hintText: "Additional Notes...",
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var form = formkey.currentState;
          if (form.validate()) {
            final task = taskkey.currentState.value;
            final note = notekey.currentState.value;
            if (isEditing) {
              updateTodo(todo, task: task, note: note);
            } else {
              addTodo(Todo(task, note: note));
            }
            Navigator.pop(context);
          }
        },
        child: Icon(isEditing ? Icons.check : Icons.add),
      ),
    );
  }

  bool get isEditing => todo != null;
}
