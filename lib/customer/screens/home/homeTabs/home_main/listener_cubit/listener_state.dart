part of 'listener_cubit.dart';

abstract class ListenerState extends Equatable {
  final bool apply;
  const ListenerState(this.apply);
}

class ListenerInitial extends ListenerState {
  ListenerInitial() : super(true);

  @override
  List<Object> get props => [apply];
}

class ListenerUpdated extends ListenerState {
  ListenerUpdated(bool apply) : super(apply);

  @override
  List<Object> get props => [apply];
}
