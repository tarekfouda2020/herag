import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'map_reply_state.dart';

class MapReplyCubit extends Cubit<MapReplyState> {
  MapReplyCubit() : super(MapReplyInitial());

  onMapChanged(){
    emit(MapReplyUpdated(showMap: !state.showMap,closeReply: state.closeReply));
  }

  onReplyChanged(){
    emit(MapReplyUpdated(showMap: state.showMap,closeReply: !state.closeReply));
  }

}
