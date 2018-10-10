import 'package:flutter/material.dart';
import 'package:my_flutter_todo_list/models.dart';

class MoreActionsButton extends StatelessWidget {
  final PopupMenuItemSelected<ExtraAction> onSelected;

  MoreActionsButton({this.onSelected, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ExtraAction>(
      onSelected: onSelected,
      itemBuilder: (context) => <PopupMenuItem<ExtraAction>>[
            PopupMenuItem<ExtraAction>(
              value: ExtraAction.toogleAllComlete,
              child: Text('Mark all complete'),
            ),
            PopupMenuItem<ExtraAction>(
              value: ExtraAction.clearCompleted,
              child: Text('Clear completed'),
            ),
          ],
    );
  }
}
