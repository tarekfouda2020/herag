part of 'call_image_cubit.dart';

abstract class CallImageState extends Equatable {
  final File file;
  const CallImageState(this.file);
}

class CallImageInitial extends CallImageState {
  CallImageInitial() : super(null);

  @override
  List<Object> get props => [file];
}

class CallImageUpdate extends CallImageState {
  CallImageUpdate(File file) : super(file);

  @override
  List<Object> get props => [file];
}
