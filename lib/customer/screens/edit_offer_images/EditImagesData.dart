part of 'EditOfferImagesImports.dart';


class EditImagesData{

  final EditImagesCubit editImagesCubit = new EditImagesCubit();

  final ExistImageCubit existImageCubit =new ExistImageCubit();

  void getImages(BuildContext context)async{
    List<File> _images=await Utils.getImages();
    if(_images.length>0){
      editImagesCubit.onOfferImageUpdated(_images);
    }
  }


  void removeImage(File image,BuildContext context){
    editImagesCubit.onOfferImageRemove(image);
  }

  void removeExistImage(int index,BuildContext context){
    existImageCubit.onExistImageRemove(index,context);
  }


  void navigateToDetails(BuildContext context,AdsDataModel adsDataModel){
    var images=editImagesCubit.state.images;
    var exists=existImageCubit.state.images;
    if((images.length+exists.length) > 5){
      LoadingDialog.showSimpleToast("ادخل علي الاكثر ٥ صور");
      return;
    }
    if(images.length>0||exists.length>0){
      UpdateAdModel model=new UpdateAdModel(
          images:images,
          adsId: adsDataModel.id.toString(),
        title: adsDataModel.title
      );
      AutoRouter.of(context).push(EditOfferLocationRoute(model: model,adModel: adsDataModel)
      );
    }else{
      LoadingDialog.showSimpleToast("قم بادخال صور الإعلان");
    }

  }

}