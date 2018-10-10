import 'package:flutter/material.dart';
import 'package:my_flutter_todo_list/models.dart';

class TodoItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final DismissDirectionCallback onDismissed;
  final ValueChanged<bool> onCheckBoxChanged;
  final Todo todo;

  const TodoItem(
      {@required this.todo,
      @required this.onDismissed,
      @required this.onTap,
      @required this.onCheckBoxChanged,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('TodoItem__${todo.id}__Checkbox'),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        title: Text(
          todo.task,
          style: Theme.of(context).textTheme.title,
        ),
        leading: Checkbox(
          value: todo.complete,
          onChanged: onCheckBoxChanged,
        ),
        subtitle: Text(
          todo.note,
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
    );
  }
}
