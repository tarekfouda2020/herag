part of 'user_comments_cubit.dart';

abstract class UserCommentsState extends Equatable {
  final List<CommentModel> comments;
  final bool change;
  const UserCommentsState({this.comments, this.change});
}

class UserCommentsInitial extends UserCommentsState {
  UserCommentsInitial():super(comments: [],change: false);
  @override
  List<Object> get props => [change,comments];
}

class UserCommentsUpdated extends UserCommentsState {
  UserCommentsUpdated(List<CommentModel> comments,bool change)
      :super(comments: comments,change: change);
  @override
  List<Object> get props => [change,comments];
}
