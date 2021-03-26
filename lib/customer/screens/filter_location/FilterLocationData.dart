part of 'FilterLocationImports.dart';

class FilterLocationData {
  final Completer<GoogleMapController> _controller = Completer();
  final GenericCubit<LocationModel> addressCubit = new GenericCubit(null);
  final GenericCubit<MarkersModel> markersCubit =
      new GenericCubit(MarkersModel(markers: {}));
  final String apiKey = "AIzaSyDIBH6mfPQ13UnF9aZtmaUQtuu-mQcxxb0";
  Set<Marker> _markers = {};
  LocationModel locationModel;

  Future<void> fetchPage(BuildContext context, {bool refresh = true}) async {
    FilterModel model = FilterModel(
      cityId: "0",
      lat: locationModel.lat,
      lng: locationModel.lng,
      catId: HomeMainData.currentCat.toString(),
      pageNumber: "1",
      pageSize: "10",
      regionId: "0",
      typeFilter: "0",
      title: "",
    );
    List<AdsModel> data =
        await CustomerRepository(context).getAdsData(model, refresh);
    setAdsMarker(data, context);
  }

  void getLocationAddress(LatLng position, BuildContext context) async {
    LatLng loc = position;
    String address = await getAddress(loc, context);
    locationModel = LocationModel(
        loc.latitude.toString(), loc.longitude.toString(), address);
    setCurrentMarker(LatLng(loc.latitude, loc.longitude));
    addressCubit.onUpdateData(locationModel);
    fetchPage(context, refresh: false);
    fetchPage(context);
  }

  Future<String> getAddress(LatLng latLng, BuildContext context) async {
    final coordinates = new Coordinates(latLng.latitude, latLng.longitude);
    List<Address> addresses =
        await Geocoder.google(apiKey, language: "ar")
            .findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
    return first.addressLine;
  }

  void setAdsMarker(List<AdsModel> ads, BuildContext context) async {
    ads.forEach((element) {
      _markers.add(Marker(
        markerId: MarkerId(element.id.toString()),
        position: LatLng(
            double.parse(element.lat ?? "0"), double.parse(element.lng ?? "0")),
        infoWindow: InfoWindow(
          title: element.title,
          anchor: Offset(0, 0),
          snippet: "رقم الاعلان : ${element.id}",
          onTap: () => AutoRouter.of(context).push(ProductDetailsRoute(model: element, info: element.info)),
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    });
    markersCubit.state.data.markers = _markers;
    markersCubit.onUpdateData(markersCubit.state.data);
  }

  void setCurrentMarker(LatLng position) async {
    _markers.clear();
    _markers.add(Marker(
      markerId: MarkerId("current"),
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    ));
    markersCubit.onUpdateData(MarkersModel(
      lat: position.latitude,
      lng: position.longitude,
      markers: _markers,
    ));
  }

  // void autoCompleteSearch(Place place, BuildContext context) async {
  //   final geolocation = await place.geolocation;
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
  //   controller
  //       .animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
  //   getLocationAddress(geolocation.coordinates, context);
  // }
}
