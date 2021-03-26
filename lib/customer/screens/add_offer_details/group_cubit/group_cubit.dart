import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/SpecificationGroupModel.dart';
import 'package:base_flutter/customer/models/SpecificationModel.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit() : super(GroupInitial(changed: false));

  onGroupUpdated(List<SpecificationGroupModel> specifications){
    emit(GroupUpdated(changed: !state.changed, specifications: specifications));
  }
}
