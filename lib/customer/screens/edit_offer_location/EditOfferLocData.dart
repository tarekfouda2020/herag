part of 'EditOfferLocImports.dart';

class EditOfferLocData {
  final GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final TextEditingController address = new TextEditingController();
  final GlobalKey<DropdownSearchState<DropDownModel>> region = new GlobalKey();
  final GlobalKey<DropdownSearchState<DropDownModel>> city = new GlobalKey();
  final GlobalKey<DropdownSearchState<DropDownModel>> neighbor =
      new GlobalKey();
  String regionId;
  String cityId;
  String neighborId;

  void setSelectRegion(DropDownModel model) {
    regionId = model != null ? model.id.toString() : null;
    city.currentState.changeSelectedItem(null);
    neighbor.currentState.changeSelectedItem(null);
  }

  void setSelectCity(DropDownModel model) {
    cityId = model != null ? model.id.toString() : null;
    neighbor.currentState.changeSelectedItem(null);
  }

  void setSelectNeighbor(DropDownModel model) {
    neighborId = model != null ? model.id.toString() : null;
  }

  void navigateToAddDetails(
      UpdateAdModel model, AdsDataModel adsDataModel, BuildContext context) {
    if (formKey.currentState.validate()) {
      if (address.text.isEmpty) {
        LoadingDialog.showSimpleToast(tr(context, "selectLocation"));
        return;
      }
      LocationModel locationModel = context.read<LocationCubit>().state.model;
      model.fkRegion = regionId;
      model.fkCity = cityId;
      model.fkDistrict = neighborId;
      model.lat = locationModel.lat;
      model.lng = locationModel.lng;
      model.location = locationModel.address;
      AutoRouter.of(context)
          .push(EditOfferDetailsRoute(model: model, adModel: adsDataModel));
    }
  }

  void navigateToLocationAddress(BuildContext context) async {
    await Utils.navigateToLocationAddress(context);
  }
}
