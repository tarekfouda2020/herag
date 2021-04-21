part of 'EditOfferImagesImports.dart';

class EditOfferImages extends StatefulWidget {
  final AdsDataModel model;

  const EditOfferImages({@required this.model});

  @override
  _AddOfferImagesState createState() => _AddOfferImagesState();
}

class _AddOfferImagesState extends State<EditOfferImages> with EditImagesData {
  @override
  void initState() {
    existImageCubit.onExistImageUpdated(widget.model.allImg);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        con: context,
        title: tr(context, "adsImages"),
      ),
      backgroundColor: MyColors.white,
      body: _buildViewContainer(context),
      bottomNavigationBar: _buildNavButton(context),
    );
  }

  Widget _buildViewContainer(BuildContext context) {
    return ListView(
      children: [
        _buildImageType(tr(context, "adsImages"), true, context),
        _buildImagesView(context),
        _buildExistImages()
      ],
    );
  }

  Widget _buildImageType(String title, bool multiple, BuildContext context) {
    return InkWell(
      onTap: () => getImages(context),
      child: Container(
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyColors.primary, width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 50, color: MyColors.black),
            MyText(
              title: title,
              size: 12,
              color: MyColors.black,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImagesView(BuildContext context) {
    return BlocBuilder<EditImagesCubit, EditImagesState>(
      bloc: editImagesCubit,
      builder: (context, state) {
        if (state is EditImagesUpdated) {
          return Column(
            children: List.generate(state.images.length, (index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width - 40,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: MyColors.primary, width: 1),
                    image: DecorationImage(
                        image: FileImage(state.images[index]),
                        colorFilter:
                            ColorFilter.mode(Colors.black12, BlendMode.darken),
                        fit: BoxFit.fill)),
                alignment: Alignment.topLeft,
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.close,
                      size: 25,
                      color: MyColors.primary,
                    ),
                  ),
                  onTap: () => removeImage(state.images[index], context),
                ),
              );
            }),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildExistImages() {
    return BlocBuilder<ExistImageCubit, ExistImageState>(
      bloc: existImageCubit,
      builder: (context, state) {
        if (state is ExistImageUpdated) {
          return Column(
            children: List.generate(state.images.length, (index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: CachedImage(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 120,
                  url: state.images[index].url,
                  borderRadius: BorderRadius.circular(5),
                  borderColor: MyColors.primary,
                  colorFilter:
                      ColorFilter.mode(Colors.black12, BlendMode.darken),
                  fit: BoxFit.fill,
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.close,
                        size: 25,
                        color: MyColors.primary,
                      ),
                    ),
                    onTap: () => _buildConfirmRemoveAd(index),
                  ),
                ),
              );
            }),
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _buildConfirmRemoveAd(int index) {
    LoadingDialog.showConfirmDialog(
      context: context,
      title: tr(context, "confirmDeleteImg"),
      confirm: () => removeExistImage(index, context),
    );
  }

  Widget _buildNavButton(BuildContext context) {
    return InkWell(
      onTap: () => navigateToDetails(context, widget.model),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: MyColors.primary,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        alignment: Alignment.center,
        child: MyText(
          title: tr(context, "continue"),
          size: 12,
          color: MyColors.white,
        ),
      ),
    );
  }
}
