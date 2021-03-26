part of  'MyProductsImports.dart';

class MyProductsData{
  final MyAdsCubit myAdsCubit=new MyAdsCubit();
  final RefreshController refreshController =new RefreshController();


  void navigateTo(BuildContext context,EditAdModel model){
    AutoRouter.of(context).push(EditOfferImagesRoute(model: model.info));
  }

}