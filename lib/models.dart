import 'utils/uuid.dart';

class AppState {
  bool isLoading;
  List<Todo> todos;

  AppState({this.isLoading = false, this.todos = const []});

  get numActive => todos.fold(0, (sum, todo) => !todo.complete ? ++sum : sum);

  get numCompited => todos.fold(0, (sum, todo) => todo.complete ? ++sum : sum);

  @override
  String toString() {
    return 'AppState{todos: $todos, isLoading: $isLoading}';
  }

  factory AppState.loading() => AppState(isLoading: true);

  filteredTodos(VisibilityFilter activeFilter) {
    return todos.where((todo) {
      if (activeFilter == VisibilityFilter.all) {
        return true;
      } else if (activeFilter == VisibilityFilter.active) {
        return !todo.complete;
      } else if (activeFilter == VisibilityFilter.completed) {
        return todo.complete;
      }
    }).toList();
  }

  void toggleAll() {
    todos.forEach((todo) => todo.complete = true);
  }

  void clearCompleted() {
    todos.removeWhere((todo)=> todo.complete);
  }
}

enum ExtraAction { toogleAllComlete, clearCompleted }

enum AppTab { todos, stats }

enum VisibilityFilter { all, active, completed }

class Todo {
  bool complete;
  String id;
  String note;
  String task;

  Todo(this.task, {this.complete = false, this.note = '', String id})
      : this.id = id ?? Uuid().generateV4();

  @override
  int get hashCode =>
      complete.hashCode ^ task.hashCode ^ note.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          id == other.id;

  @override
  String toString() {
    return 'Todo{complete: $complete, task: $task, note: $note, id: $id}';
  }
}

typedef TodoUpdater(Todo todo,
    {bool complite, String id, String note, String task});

typedef TodoRemover(Todo todo);

typedef TodoAdder(Todo todo);
