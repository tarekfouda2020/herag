part of 'map_reply_cubit.dart';

abstract class MapReplyState extends Equatable {
  final bool showMap;
  final bool closeReply;
  const MapReplyState({this.showMap, this.closeReply});
}

class MapReplyInitial extends MapReplyState {
  MapReplyInitial():super(closeReply: false,showMap: true);
  @override
  List<Object> get props => [closeReply,showMap];
}

class MapReplyUpdated extends MapReplyState {
  MapReplyUpdated({bool showMap, bool closeReply}):super(closeReply: closeReply,showMap: showMap);
  @override
  List<Object> get props => [closeReply,showMap];
}
