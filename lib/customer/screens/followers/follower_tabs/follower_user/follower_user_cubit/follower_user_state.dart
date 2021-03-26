part of 'follower_user_cubit.dart';

abstract class FollowerUserState extends Equatable {
  final List<UserFollowerModel> followers;
  final bool change ;
  const FollowerUserState({this.followers, this.change});
}

class FollowerUserInitial extends FollowerUserState {
  FollowerUserInitial() : super(followers: [],change: false);

  @override
  List<Object> get props => [followers,change];
}
class FollowerUserUpdated extends FollowerUserState {
  FollowerUserUpdated(List<UserFollowerModel> followers,bool change) :
        super(followers: followers,change: change);

  @override
  List<Object> get props => [followers,change];
}