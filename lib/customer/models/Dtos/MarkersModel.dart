import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkersModel{
  Set<Marker> markers;
  double lat;
  double lng;

  MarkersModel({this.markers, this.lat, this.lng});
}