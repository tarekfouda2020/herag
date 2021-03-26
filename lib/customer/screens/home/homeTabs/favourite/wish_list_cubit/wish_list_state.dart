part of 'wish_list_cubit.dart';

abstract class WishListState extends Equatable {
  final List<AdsModel> ads;
  final bool changed;
  const WishListState({this.ads, this.changed});
}

class WishListInitial extends WishListState {
  WishListInitial():super(ads: [],changed: false);
  @override
  List<Object> get props => [changed,ads];
}

class WishListUpdated extends WishListState {
  WishListUpdated({List<AdsModel> ads, bool changed}):super(ads: ads,changed: changed);
  @override
  List<Object> get props => [changed,ads];
}
