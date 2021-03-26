import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:base_flutter/customer/models/MessageModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  onUpdateMessages(List<MessageModel> messages){
    emit(ChatUpdated(messages, !state.changed));
  }

  fetchData(BuildContext context,String userId)async{
    List<MessageModel> messages = await CustomerRepository(context).getListChatMessages(userId,1);
    onUpdateMessages(messages);
  }

}
