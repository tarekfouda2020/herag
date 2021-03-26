import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/SpecificationHeaderModel.dart';

part 'header_state.dart';

class HeaderCubit extends Cubit<HeaderState> {
  HeaderCubit() : super(HeaderInitial(changed: false));
  onHeaderUpdated(List<SpecificationHeaderModel> headers){
    emit(HeaderUpdated(changed: !state.changed, headers: headers));
  }
}
