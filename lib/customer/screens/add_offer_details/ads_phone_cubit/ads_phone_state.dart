part of 'ads_phone_cubit.dart';

abstract class AdsPhoneState extends Equatable {
  final bool showPhone;
  final bool showPrice;
  const AdsPhoneState({this.showPhone, this.showPrice});
}

class AdsPhoneInitial extends AdsPhoneState {
  AdsPhoneInitial() : super(showPhone: false,showPrice: false);

  @override
  List<Object> get props => [showPrice,showPhone];
}

class AdsPhoneUpdated extends AdsPhoneState {
  AdsPhoneUpdated({bool showPhone, bool showPrice}) : super(showPhone: showPhone,showPrice: showPrice);

  @override
  List<Object> get props => [showPrice,showPhone];
}
