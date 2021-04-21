part of 'AddOfferImagesImports.dart';

class AddOfferImages extends StatefulWidget {
  final OffersHeaderModel model;

  const AddOfferImages({@required this.model});

  @override
  _AddOfferImagesState createState() => _AddOfferImagesState();
}

class _AddOfferImagesState extends State<AddOfferImages> with AddImagesData {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(con: context,title: tr(context,"adsImages"),),
      backgroundColor: MyColors.white,
      body: _buildViewContainer(context),
    );
  }

  Widget _buildViewContainer(BuildContext context){
    return Column(
      children: [
        _buildImageType(tr(context,"addAdsImg"),true,context),
        BlocBuilder<AddAdsImagesCubit,AddAdsImagesState>(
          bloc: addOfferCubit,
          builder: (context,state){
            return Flexible(
              child: ReorderableListView(
                onReorder: reorderData,
                children: List.generate(state.images.length, (index){
                  return _buildImagesView(context,state.images[index]);
                }),
              ),
            );
          },
        ),
        DefaultButton(
          margin: EdgeInsets.all(20),
          title: tr(context,"continue"),
          onTap: ()=>navigateToDetails(context,widget.model),
        ),
      ],
    );
  }

  Widget _buildImageType(String title,bool multiple,BuildContext context){
    return InkWell(
      onTap: ()=>getImages(context),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyColors.primary,width: 1)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add,size: 50,color: MyColors.black),
            MyText(title: title,size: 12,color: MyColors.black,)
          ],
        ),
      ),
    );
  }

  Widget _buildImagesView(BuildContext context,File image){
    return Container(
      key: ValueKey(image),
      margin: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width-40,
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: MyColors.primary,width: 1),
          image: DecorationImage(
              image: FileImage(image),
              colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
              fit: BoxFit.fill
          )
      ),
      alignment: Alignment.topLeft,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(Icons.close,size: 25,color: MyColors.primary,),
        ),
        onTap: ()=>removeImage(image,context),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context){
    return InkWell(
      onTap: ()=>navigateToDetails(context,widget.model),
      child: Container(
        height: Platform.isIOS? 75 : 50,
        decoration: BoxDecoration(
          color: MyColors.primary,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20)
          ),
        ),
        alignment: Alignment.center,
        child: MyText(title: tr(context,"continue"),size: 12,color: MyColors.white,),
      ),
    );
  }

}




