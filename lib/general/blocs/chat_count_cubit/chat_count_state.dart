part of 'chat_count_cubit.dart';

abstract class ChatCountState extends Equatable {
  final int count;
  const ChatCountState(this.count);
}

class ChatCountInitial extends ChatCountState {
  ChatCountInitial() : super(0);

  @override
  List<Object> get props => [count];
}

class ChatCountUpdate extends ChatCountState {
  ChatCountUpdate(int count) : super(count);

  @override
  List<Object> get props => [count];
}
