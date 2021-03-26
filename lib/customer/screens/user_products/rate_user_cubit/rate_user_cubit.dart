import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/AdsDataModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';
import 'package:base_flutter/customer/screens/user_products/ad_owner_cubit/add_owner_cubit.dart';

part 'rate_user_state.dart';

class RateUserCubit extends Cubit<RateUserState> {
  RateUserCubit() : super(RateUserInitial());

  onUpdateRateValue(double rate){
    emit(RateUserUpdated(rate: rate));
  }


  setRateUser(BuildContext context,String userId,AddOwnerCubit addOwnerCubit)async{
    int result = await CustomerRepository(context).addUserRate(userId ,state.rate.toInt());
    if(result!=0){
      addOwnerCubit.onUpdateRate(true);
    }
    Navigator.pop(context);

  }

}
