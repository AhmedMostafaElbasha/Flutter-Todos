import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();
}

class TabUpdated extends TabEvent {
  final AppTab tab;

  const TabUpdated(this.tab);

  @override
  // TODO: implement props
  List<Object> get props => [tab];

  @override
  String toString() {
    // TODO: implement toString
    return 'TabUpdated { tab: $tab }';
  }
}
