import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import '../blocs.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TodosBloc todosBloc;
  StreamSubscription todosSubscription;

  StatsBloc({@required this.todosBloc}) : super(StatsLoadInProgress()) {
    todosSubscription = todosBloc.listen((state) {
      if (state is TodosLoadSuccessState) {
        add(StatsUpdated(state.todos));
      }
    });
  }

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is StatsUpdated) {
      int numActive =
          event.todos.where((todo) => !todo.complete).toList().length;
      int numCompleted =
          event.todos.where((todo) => todo.complete).toList().length;
      yield StatsLoadSuccess(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    todosSubscription.cancel();
    return super.close();
  }
}
