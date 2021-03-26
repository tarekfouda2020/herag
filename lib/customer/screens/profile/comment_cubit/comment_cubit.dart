import 'package:base_flutter/general/blocs/lang_cubit/lang_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/CommentModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());

  onSetCommentsList(List<CommentModel> comments){
    emit(CommentUpdated(comments: comments,change: !state.change));
  }

  setFetchData(BuildContext context)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    var comments = await CustomerRepository(context).getMyComments(lang);
    onSetCommentsList(comments);
  }

  setRefreshData(BuildContext context,RefreshController refreshController)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    var comments = await CustomerRepository(context).getMyComments(lang);
    onSetCommentsList(comments);
    refreshController.refreshCompleted();
  }


  // Future<void> setAddReply(BuildContext context,int id,String reply)async{
  //   var comment = await CustomerRepository(context).addAdReply("$id", reply);
  //   if(comment!=null){
  //   }
  // }


}
