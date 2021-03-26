part of 'rate_user_cubit.dart';

abstract class RateUserState extends Equatable {
  final double rate;
  const RateUserState({this.rate});
}

class RateUserInitial extends RateUserState {
  RateUserInitial() : super(rate: 0);

  @override
  List<Object> get props => [rate];
}

class RateUserUpdated extends RateUserState {
  RateUserUpdated({double rate,double preRate, bool showRate}) :
        super(rate: rate);

  @override
  List<Object> get props => [rate];
}
