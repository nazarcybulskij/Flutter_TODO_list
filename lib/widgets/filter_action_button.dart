import 'package:flutter/material.dart';
import 'package:my_flutter_todo_list/models.dart';

class FilterActionButton extends StatelessWidget {
  final PopupMenuItemSelected<VisibilityFilter> onSelected;
  final VisibilityFilter activeFilter;
  final bool isActive;

  const FilterActionButton(
      {this.onSelected, this.activeFilter, this.isActive, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.body1;
    final activeStyle = Theme.of(context)
        .textTheme
        .body1
        .copyWith(color: Theme.of(context).accentColor);

    final button = _Button(
      activeFilter: activeFilter,
      onSelected: onSelected,
      defaultStyle: defaultStyle,
      activeStyle: activeStyle,
    );

    return AnimatedOpacity(
      opacity: isActive ? 1.0 : 0.0,
      duration: Duration(milliseconds: 150),
      child: isActive
          ? button
          : IgnorePointer(
              child: button,
            ),
    );
  }
}

class _Button extends StatelessWidget {
  final PopupMenuItemSelected<VisibilityFilter> onSelected;
  final VisibilityFilter activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  const _Button(
      {@required this.onSelected,
      @required this.activeFilter,
      @required this.activeStyle,
      @required this.defaultStyle,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      onSelected: onSelected,
      itemBuilder: (context) => <PopupMenuItem<VisibilityFilter>>[
            PopupMenuItem<VisibilityFilter>(
              value: VisibilityFilter.all,
              child: Text(
                "Show All",
                style: activeFilter == VisibilityFilter.all
                    ? activeStyle
                    : defaultStyle,
              ),
            ),
            PopupMenuItem<VisibilityFilter>(
              value: VisibilityFilter.active,
              child: Text(
                "Show Active",
                style: activeFilter == VisibilityFilter.active
                    ? activeStyle
                    : defaultStyle,
              ),
            ),
            PopupMenuItem<VisibilityFilter>(
              value: VisibilityFilter.completed,
              child: Text(
                "Show Completed",
                style: activeFilter == VisibilityFilter.completed
                    ? activeStyle
                    : defaultStyle,
              ),
            ),
          ],
      icon: Icon(Icons.filter_list),
    );
  }
}
