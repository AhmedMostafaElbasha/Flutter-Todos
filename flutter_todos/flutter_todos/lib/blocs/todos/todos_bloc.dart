import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';
import '../todos/todos.dart';
import '../../models/models.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepositoryFlutter todosRepository;

  TodosBloc({@required this.todosRepository}) : super(TodosLoadInProgress());

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

  Stream<TodosState> _mapTodosLoadedToState() async* {
    try {
      final todos = await todosRepository.loadTodos();
      yield TodosLoadSuccessState(
        todos: todos.map(Todo.fromEntity).toList(),
      );
    } catch (_) {
      yield TodosLoadFailure();
    }
  }

  Stream<TodosState> _mapTodoAddedToState(TodoAdded event) async* {
    if (state is TodosLoadSuccessState) {
      final List<Todo> updatedTodos =
          List.from((state as TodosLoadSuccessState).todos)..add(event.todo);
      yield TodosLoadSuccessState(todos: updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapTodoUpdatedToState(TodoUpdated event) async* {
    if (state is TodosLoadSuccessState) {
      final List<Todo> updatedTodos =
          (state as TodosLoadSuccessState).todos.map(
        (todo) {
          return todo.id == event.todo.id ? event.todo : todo;
        },
      ).toList();
      yield TodosLoadSuccessState(todos: updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    return todosRepository.saveTodos(
      todos.map((todo) => todo.toEntity()).toList(),
    );
  }
}
