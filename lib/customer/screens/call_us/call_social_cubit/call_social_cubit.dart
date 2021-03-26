import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/ContactModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';

part 'call_social_state.dart';

class CallSocialCubit extends Cubit<CallSocialState> {
  CallSocialCubit() : super(CallSocialInitial());

  onUpdateModel(ContactModel model){
    emit(CallSocialUpdate(model, !state.change));
  }

  void fetchData(BuildContext context)async{
    var data = await CustomerRepository(context).getContactInfo();
    if(data!=null){
      onUpdateModel(data);
    }
  }

}
