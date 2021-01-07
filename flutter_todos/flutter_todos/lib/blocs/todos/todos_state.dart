import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TodosLoadInProgress extends TodosState {}

class TodosLoadSuccessState extends TodosState {
  final List<Todo> todos;

  const TodosLoadSuccessState({this.todos = const []});

  @override
  // TODO: implement props
  List<Object> get props => [todos];

  @override
  String toString() {
    // TODO: implement toString
    return 'TodosLoadSuccess { todos: $todos }';
  }
}

class TodosLoadFailure extends TodosState {}
