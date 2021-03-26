import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'listener_state.dart';

class ListenerCubit extends Cubit<ListenerState> {
  ListenerCubit() : super(ListenerInitial());

  onUpdateApplyListener(bool apply){
    emit(ListenerUpdated(apply));
  }

}
