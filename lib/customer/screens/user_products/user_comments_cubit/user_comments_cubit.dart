import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/CommentModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';

part 'user_comments_state.dart';

class UserCommentsCubit extends Cubit<UserCommentsState> {
  UserCommentsCubit() : super(UserCommentsInitial());

  onUpdateUserComments(List<CommentModel> comments){
    emit(UserCommentsUpdated(comments, !state.change));
  }

  fetchUserComment(BuildContext context,String id,{bool refresh = true})async{
    if(state.comments.length==0){
      List<CommentModel> lst=await CustomerRepository(context).getUserComments(id,refresh);
      onUpdateUserComments(lst);
    }
  }

}
