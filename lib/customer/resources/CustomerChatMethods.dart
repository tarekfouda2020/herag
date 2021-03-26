import 'package:base_flutter/general/blocs/lang_cubit/lang_cubit.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/ChatModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_flutter/customer/models/MessageModel.dart';
import 'package:base_flutter/general/blocs/chat_count_cubit/chat_count_cubit.dart';
import 'package:base_flutter/general/blocs/user_cubit/user_cubit.dart';
import 'package:base_flutter/general/models/UserModel.dart';
import 'package:base_flutter/general/utilities/dio_helper/DioImports.dart';

class CustomerChatMethods{
  final BuildContext context;

  CustomerChatMethods(this.context);

  Future<List<ChatModel>> getListChatUsers(bool refresh)async{
    String lang=context.read<LangCubit>().state.locale.languageCode;
    UserModel user=context.read<UserCubit>().state.model;
    Map<String,dynamic> body={
      "lang":lang,
      "UserId":user.id
    };
    var _data = await DioHelper(forceRefresh: refresh).get("/api/v1/ListUsersMyChat", body);
    if(_data!=null){
      return List<ChatModel>.from(_data["data"].map((e) => ChatModel.fromMap(e)));
    }else{
      return null;
    }
  }

  Future<List<MessageModel>> getListChatMessages(String ReceiverId,int page)async{
    String lang=context.read<LangCubit>().state.locale.languageCode;
    UserModel user=context.read<UserCubit>().state.model;
    Map<String,dynamic> body={
      "lang":lang,
      "ReceiverId":ReceiverId,
      "SenderId":user.id
    };
    var _data = await DioHelper(forceRefresh: true).get("/api/v1/GetAllMessageBetweenTwoUser", body);
    if(_data!=null){
      context.read<ChatCountCubit>().onUpdateCount(_data["countChat"]??0);
      return List<MessageModel>.from(_data["data"].map((e) => MessageModel.fromMap(e)));
    }else{
      return null;
    }
  }

  Future<bool> addUserReport(String id,String reason)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "fkUser":id,
      "reason":reason
    };
    var _data = await DioHelper().post("/api/v1/AddReporToUser", body);
    return (_data!=null);
  }

}