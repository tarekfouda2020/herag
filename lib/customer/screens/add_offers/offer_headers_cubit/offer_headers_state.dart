part of 'offer_headers_cubit.dart';

abstract class OfferHeadersState extends Equatable {
  final List<OffersHeaderModel> headers;
  final bool changed;

  OfferHeadersState({this.headers, this.changed});
}

class OfferHeadersInitial extends OfferHeadersState {
  OfferHeadersInitial():super(headers: [],changed: false);
  @override
  List<Object> get props => [headers,changed];
}

class OfferHeadersUpdate extends OfferHeadersState {
  OfferHeadersUpdate(List<OffersHeaderModel> headers,bool changed):super(headers: headers,changed: changed);
  @override
  List<Object> get props => [headers,changed];
}
