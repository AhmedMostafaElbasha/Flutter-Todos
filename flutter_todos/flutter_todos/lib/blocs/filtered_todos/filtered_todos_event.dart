import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();
}

class FilterUpdated extends FilteredTodosEvent {
  final VisibilityFilter filter;

  const FilterUpdated(this.filter);

  @override
  // TODO: implement props
  List<Object> get props => [filter];

  @override
  String toString() {
    // TODO: implement toString
    return 'FilterUpdated { filter: $filter }';
  }
}

class TodosUpdated extends FilteredTodosEvent {
  final List<Todo> todos;

  const TodosUpdated(this.todos);

  @override
  // TODO: implement props
  List<Object> get props => [todos];

  @override
  String toString() {
    // TODO: implement toString
    return 'TodosUpdated { todos: $todos }';
  }
}
