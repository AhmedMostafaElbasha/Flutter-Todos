import 'package:equatable/equatable.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class StatsLoadInProgress extends StatsState {}

class StatsLoadSuccess extends StatsState {
  final int numActive;
  final int numCompleted;

  const StatsLoadSuccess(this.numActive, this.numCompleted);

  @override
  // TODO: implement props
  List<Object> get props => [numActive, numCompleted];

  @override
  String toString() {
    // TODO: implement toString
    return 'StateLoadSuccess { numActive: $numActive, numCompleted: $numCompleted }';
  }
}
