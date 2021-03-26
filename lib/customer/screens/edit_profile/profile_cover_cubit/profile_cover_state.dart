part of 'profile_cover_cubit.dart';

abstract class ProfileCoverState extends Equatable {
  final File image;
  const ProfileCoverState(this.image);
}

class ProfileCoverInitial extends ProfileCoverState {
  ProfileCoverInitial() : super(null);

  @override
  List<Object> get props => [image];
}
class ProfileCoverUpdate extends ProfileCoverState {
  ProfileCoverUpdate(File image) : super(image);

  @override
  List<Object> get props => [image];
}
