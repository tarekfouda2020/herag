part of 'pay_cubit.dart';

abstract class PayState extends Equatable {
  final File image;
  const PayState(this.image);
}

class PayInitial extends PayState {
  PayInitial() : super(null);

  @override
  List<Object> get props => [image];
}


class PayUpdateState extends PayState {
  PayUpdateState(File image) : super(image);

  @override
  List<Object> get props => [image];
}
