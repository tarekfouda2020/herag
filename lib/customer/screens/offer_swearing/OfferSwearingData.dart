part of  'OfferSwearingImports.dart';

class OfferSwearingData{


  final SwearingCubit swearingCubit=new SwearingCubit();

  void setChangeAcceptSate(bool value){
    swearingCubit.onAcceptChanged();
  }

  void navigateToAddOfferImages(BuildContext context,OffersHeaderModel model){
    if(swearingCubit.state.accepted){
      AutoRouter.of(context).push(AddOfferImagesRoute(model: model)
      );
    }else{
      LoadingDialog.showSimpleToast("قم بالموافقة علي الإتفاقية");
    }
  }
}