import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class StatsUpdated extends StatsEvent {
  final List<Todo> todos;

  const StatsUpdated(this.todos);

  @override
  // TODO: implement props
  List<Object> get props => [todos];

  @override
  String toString() {
    // TODO: implement toString
    return 'StatsUpdated { todos: $todos }';
  }
}
