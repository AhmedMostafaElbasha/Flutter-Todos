import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../todos/todos.dart';
import '../../models/models.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepositoryFlutter todosRepository;

  TodosBloc({@required this.todosRepository}) : super(TodosLoadInProgress());

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is TodosLoadSuccessEvent) {
      yield* _mapTodoLoadedToState();
    } else if (event is TodoAdded) {
      yield* _mapTodoAddedToState(event);
    } else if (event is TodoUpdated) {
      yield* _mapTodoUpdatedToState(event);
    } else if (event is TodoDeleted) {
      yield* _mapTodoDeletedToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<TodosState> _mapTodoLoadedToState() async* {
    try {
      final todos = await todosRepository.loadTodos();
      yield TodosLoadSuccessState(
        todos.map(Todo.fromEntity).toList(),
      );
    } catch (_) {
      yield TodosLoadFailure();
    }
  }

  Stream<TodosState> _mapTodoAddedToState(TodoAdded event) async* {
    if (state is TodosLoadSuccessState) {
      final List<Todo> updatedTodos =
          List.from((state as TodosLoadSuccessState).todos)..add(event.todo);
      yield TodosLoadSuccessState(updatedTodos);
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
      yield TodosLoadSuccessState(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapTodoDeletedToState(TodoDeleted event) async* {
    if (state is TodosLoadSuccessState) {
      final updatedTodos = (state as TodosLoadSuccessState)
          .todos
          .where((todo) => todo.id != event.todo.id)
          .toList();
      yield TodosLoadSuccessState(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapToggleAllToState() async* {
    if (state is TodosLoadSuccessState) {
      final allComplete =
          (state as TodosLoadSuccessState).todos.every((todo) => todo.complete);
      final List<Todo> updatedTodos = (state as TodosLoadSuccessState)
          .todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      yield TodosLoadSuccessState(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    if (state is TodosLoadSuccessState) {
      final List<Todo> updatedTodos = (state as TodosLoadSuccessState)
          .todos
          .where((todo) => !todo.complete)
          .toList();
      yield TodosLoadSuccessState(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    return todosRepository.saveTodos(
      todos.map((todo) => todo.toEntity()).toList(),
    );
  }
}
