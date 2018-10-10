import 'package:flutter/material.dart';
import 'package:my_flutter_todo_list/widgets/more_actions_button.dart';
import 'package:my_flutter_todo_list/models.dart';
import 'package:my_flutter_todo_list/routes.dart';
import 'package:my_flutter_todo_list/widgets/todo_list.dart';
import 'package:my_flutter_todo_list/widgets/stat_counter.dart';
import 'package:my_flutter_todo_list/widgets/filter_action_button.dart';

class HomeScreen extends StatefulWidget {
  final AppState appState;
  final TodoAdder addTodo;
  final TodoUpdater updateTodo;
  final TodoRemover removeTodo;
  final Function toggleAll;
  final Function clearCompleted;

  const HomeScreen({
    @required this.appState,
    @required this.addTodo,
    @required this.updateTodo,
    @required this.removeTodo,
    @required this.toggleAll,
    @required this.clearCompleted,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  VisibilityFilter activeFilter = VisibilityFilter.all;
  AppTab activeTab = AppTab.todos;

  PageController pageController;

  _updateTab(AppTab tab) {
    setState(() {
      activeTab = tab;
    });
  }

  void _updateVisible(VisibilityFilter filter) {
    setState(() {
      activeFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO List'),
        actions: <Widget>[
          FilterActionButton(
            onSelected: _updateVisible,
            isActive: activeTab == AppTab.todos,
            activeFilter: activeFilter,
          ),
          MoreActionsButton(
            onSelected: (action) {
              if (action == ExtraAction.toogleAllComlete) {
                widget.toggleAll();
              }else if (action == ExtraAction.clearCompleted){
                widget.clearCompleted();
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, TodoAppRoutes.addTodo);
        },
        child: Icon(Icons.add),
      ),
      body: PageView(
        controller: pageController ,
        onPageChanged: onPageChanged,
        children: <Widget>[
          TodoList(
            addTodo: widget.addTodo,
            updateTodo: widget.updateTodo,
            removeTodo: widget.removeTodo,
            filteredTodos: widget.appState.filteredTodos(activeFilter),
            loading: widget.appState.isLoading,
          ),
          StatCounter(
            numActive: widget.appState.numActive,
            numCompited: widget.appState.numCompited,
          ),
        ],
      ),
//      body: AppTab.todos == activeTab
//          ? TodoList(
//              addTodo: widget.addTodo,
//              updateTodo: widget.updateTodo,
//              removeTodo: widget.removeTodo,
//              filteredTodos: widget.appState.filteredTodos(activeFilter),
//              loading: widget.appState.isLoading,
//            )
//          : StatCounter(
//              numActive: widget.appState.numActive,
//              numCompited: widget.appState.numCompited,
//            ),
      bottomNavigationBar: BottomNavigationBar(
        items: AppTab.values.map((tab) {
          return BottomNavigationBarItem(
              icon: Icon(tab == AppTab.todos ? Icons.list : Icons.show_chart),
              title: Text(tab == AppTab.todos ? 'TODO' : 'Statistic'));
        }).toList(),
        onTap: (index) {
          pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
          _updateTab(AppTab.values[index]);
        },
        currentIndex: AppTab.values.indexOf(activeTab),
      ),
    );
  }

  void onPageChanged(int page) {
   _updateTab(AppTab.values[page]);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
