part of 'add_ads_images_cubit.dart';

abstract class AddAdsImagesState extends Equatable {
  final List<File> images;
  final bool changed;
  const AddAdsImagesState({this.images, this.changed});
}

class AddAdsImagesInitial extends AddAdsImagesState {
  AddAdsImagesInitial() : super(images: [],changed: false);

  @override
  List<Object> get props => [changed,images];
}

class AddAdsImagesUpdated extends AddAdsImagesState {
  AddAdsImagesUpdated(List<File> images, bool changed) : super(images: images,changed: changed);

  @override
  List<Object> get props => [changed,images];
}
