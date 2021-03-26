import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'swearing_state.dart';

class SwearingCubit extends Cubit<SwearingState> {
  SwearingCubit() : super(SwearingInitial());

  onAcceptChanged(){
    emit(SwearingChangedState(!state.accepted));
  }

}
