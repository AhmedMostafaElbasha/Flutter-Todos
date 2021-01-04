import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../blocs/blocs.dart';
import '../../models/models.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;
  StreamSubscription todosSubscription;

  FilteredTodosBloc({@required this.todosBloc})
      : super(
          todosBloc.state is TodosLoadSuccessState
              ? FilteredTodosLoadSuccess(
                  (todosBloc.state as TodosLoadSuccessState).todos,
                  VisibilityFilter.all,
                )
              : FilteredTodosLoadInProgress(),
        ) {
    todosSubscription = todosBloc.listen((state) {
      if (state is TodosLoadSuccessState) {
        add(TodosUpdated((todosBloc.state as TodosLoadSuccessState).todos));
      }
    });
  }

  @override
  Stream<FilteredTodosState> mapEventToState(FilteredTodosEvent event) async* {
    if (event is FilterUpdated) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is TodosUpdated) {
      yield* _mapTodosUpdatedToState(event);
    }
  }

  Stream<FilteredTodosState> _mapUpdateFilterToState(
    FilterUpdated event,
  ) async* {
    if (todosBloc.state is TodosLoadSuccessState) {
      yield FilteredTodosLoadSuccess(
        _mapTodosToFilteredTodos(
          (todosBloc.state as TodosLoadSuccessState).todos,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<FilteredTodosState> _mapTodosUpdatedToState(
    TodosUpdated event,
  ) async* {
    final visibilityFilter = state is FilteredTodosLoadSuccess
        ? (state as FilteredTodosLoadSuccess).activeFilter
        : VisibilityFilter.all;
    yield FilteredTodosLoadSuccess(
      _mapTodosToFilteredTodos(
        (todosBloc.state as TodosLoadSuccessState).todos,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Todo> _mapTodosToFilteredTodos(
      List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    // TODO: implement close
    todosSubscription.cancel();
    return super.close();
  }
}
