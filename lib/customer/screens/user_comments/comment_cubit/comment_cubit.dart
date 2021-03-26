import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/CommentModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';


part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());

  onSetCommentsList(List<CommentModel> comments){
    emit(CommentUpdated(comments: comments,change: !state.change));
  }

  setFetchData(BuildContext context,String id,{bool refresh=true})async{
    if(state.comments.length==0){
      var comments = await CustomerRepository(context).getUserComments(id,refresh);
      onSetCommentsList(comments);
    }
  }

  Future<void> setAddComment(BuildContext context,String id,String text)async{
    var comment = await CustomerRepository(context).addUserComments("$id", text);
    if(comment!=null){
      state.comments.add(comment);
      onSetCommentsList(state.comments);
    }
  }


  Future<void> setRemoveComment(BuildContext context,CommentModel model)async{
    var result = await CustomerRepository(context).removeUserComment("${model.id}");
    if(result){
      state.comments.remove(model);
      onSetCommentsList(state.comments);
      Navigator.pop(context);
    }
  }

}
