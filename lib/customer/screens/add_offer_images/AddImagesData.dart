part of 'AddOfferImagesImports.dart';


class AddImagesData{

  final AddAdsImagesCubit addOfferCubit = new AddAdsImagesCubit();

  void getImages(BuildContext context)async{
    List<File> _images=await Utils.getImages();
    if(_images.length>0){
      _images.addAll(addOfferCubit.state.images);
      addOfferCubit.onUpdateAdImages(_images);
    }
  }

  void removeImage(File image,BuildContext context){
    List<File> _images= addOfferCubit.state.images;
    _images.remove(image);
    addOfferCubit.onUpdateAdImages(List.from(_images));

  }

  void navigateToDetails(BuildContext context,OffersHeaderModel headerModel){
    var images=addOfferCubit.state.images;
    if(images.length>5){
      LoadingDialog.showSimpleToast("ادخل علي الاكثر ٥ صور");
      return;
    }
    if(images.length>0){
      AddAdsModel model=new AddAdsModel(
          images:images,
          fkHeaderAds: headerModel.id.toString()
      );
      AutoRouter.of(context).push(AddOfferLocationRoute(model: model)
      );
    }else{
      LoadingDialog.showSimpleToast("قم بادخال صور الإعلان");
    }

  }

  void reorderData(int oldIndex, int newIndex){
    if(newIndex>oldIndex){
      newIndex-=1;
    }
    final items =addOfferCubit.state.images.removeAt(oldIndex);
    addOfferCubit.state.images.insert(newIndex, items);
    addOfferCubit.onUpdateAdImages(addOfferCubit.state.images);
  }

}