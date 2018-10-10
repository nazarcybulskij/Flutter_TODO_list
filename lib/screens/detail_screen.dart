import 'package:flutter/material.dart';
import 'add_edit_screen.dart';
import 'package:my_flutter_todo_list/models.dart';

class DetailScreen extends StatelessWidget {
  final Todo todo;
  final TodoAdder addTodo;
  final TodoUpdater updateTodo;
  final Function onDelete;

  const DetailScreen(
      {@required this.todo,
      @required this.addTodo,
      @required this.updateTodo,
      @required this.onDelete,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Checkbox(
                    value: todo.complete,
                    onChanged: (complite) {
                      updateTodo(todo, complite: !todo.complete);
                    },
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                      child: Text(
                        todo.task,
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ),
                    Text(
                      todo.note,
                      style: Theme.of(context).textTheme.subhead,
                    )
                  ],
                )),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AddEditScreen(
                todo: todo,
                addTodo: addTodo,
                updateTodo: updateTodo,
              );
            }));
          }),
    );
  }
}
