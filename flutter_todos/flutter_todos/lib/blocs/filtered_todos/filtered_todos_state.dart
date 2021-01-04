import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class FilteredTodosState extends Equatable {
  const FilteredTodosState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FilteredTodosLoadInProgress extends FilteredTodosState {}

class FilteredTodosLoadSuccess extends FilteredTodosState {
  final List<Todo> filteredTodos;
  final VisibilityFilter activeFilter;

  const FilteredTodosLoadSuccess(
    this.filteredTodos,
    this.activeFilter,
  );

  @override
  // TODO: implement props
  List<Object> get props => [filteredTodos, activeFilter];

  @override
  String toString() {
    // TODO: implement toString
    return 'FilteredTodosLoadSuccess { filteredTodos: $filteredTodos, activeFilter: $activeFilter }';
  }
}
