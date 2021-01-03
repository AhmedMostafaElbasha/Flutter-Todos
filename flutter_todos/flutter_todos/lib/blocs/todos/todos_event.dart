import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TodosLoadSuccessEvent extends TodosEvent {}

class TodoAdded extends TodosEvent {
  final Todo todo;

  const TodoAdded(this.todo);

  @override
  // TODO: implement props
  List<Object> get props => [todo];

  @override
  String toString() {
    // TODO: implement toString
    return 'TodoAdded { todo: $todo }';
  }
}

class TodoUpdated extends TodosEvent {
  final Todo todo;

  const TodoUpdated(this.todo);

  @override
  // TODO: implement props
  List<Object> get props => [todo];

  @override
  String toString() {
    // TODO: implement toString
    return 'TodoUpdated { todo: $todo }';
  }
}

class TodoDeleted extends TodosEvent {
  final Todo todo;

  const TodoDeleted(this.todo);

  @override
  // TODO: implement props
  List<Object> get props => [todo];

  @override
  String toString() {
    // TODO: implement toString
    return 'TodoDeleted { todo: $todo }';
  }
}

class ClearCompleted extends TodosEvent {}

class ToggleAll extends TodosEvent {}
