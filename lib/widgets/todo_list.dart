import 'package:flutter/material.dart';
import 'todo_item.dart';
import 'package:my_flutter_todo_list/screens/detail_screen.dart';
import 'package:my_flutter_todo_list/models.dart';

class TodoList extends StatelessWidget {
  final TodoAdder addTodo;
  final TodoUpdater updateTodo;
  final TodoRemover removeTodo;
  final List<Todo> filteredTodos;
  final bool loading;

  const TodoList(
      {@required this.filteredTodos,
      @required this.loading,
      @required this.addTodo,
      @required this.updateTodo,
      @required this.removeTodo,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: filteredTodos.length,
              itemBuilder: (context, index) {
                var todo = filteredTodos[index];
                return TodoItem(
                  onCheckBoxChanged: (complite) {
                    updateTodo(todo, complite: !todo.complete);
                  },
                  onDismissed: (direction) {
                    _removeTodo(context, todo);
                  },
                  todo: todo,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return DetailScreen(
                        todo: todo,
                        updateTodo: updateTodo,
                        onDelete: () => _removeTodo(context, todo),
                      );
                    }));
                  },
                );
              },
            ),
    );
  }

  _removeTodo(BuildContext context, Todo todo) {
    removeTodo(todo);
    Scaffold.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(
        todo.task,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            addTodo(todo);
          }),
    ));
  }
}
