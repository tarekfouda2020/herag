part of 'MyProductsImports.dart';

class MyProducts extends StatefulWidget  {
  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> with MyProductsData{

  @override
  void initState() {
    myAdsCubit.fetchUserAds(context,refresh: false);
    myAdsCubit.fetchUserAds(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "اعلاناتي", con: context),
      backgroundColor: MyColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // _buildHeaderView(user),
          _buildProductListView()
        ],
      ),
    );
  }

  Widget _buildHeaderView(UserModel user){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Icon(Icons.person_outline,size: 25,color: MyColors.black,),
              ),
              MyText(title: user.userName ,size: 10,color: MyColors.black,),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(title: user.publishDate,size: 10,color: MyColors.blackOpacity,),
                RatingBar.builder(
                  initialRating: user.rate.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  updateOnDrag: false,
                  onRatingUpdate: (rate){},
                  ignoreGestures: true,
                  itemCount: 5,
                  itemSize: 16,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductListView(){
    return BlocBuilder<MyAdsCubit,MyAdsState>(
      bloc: myAdsCubit,
      builder: (context,state){
        if(state is MyAdsUpdated){
          if(state.ads.length>0){
            return _buildProductsView(state.ads);
          }else{
            return Center(
              child: MyText(title: "لايوجد بيانات",size: 12,color: MyColors.blackOpacity,),
            );
          }
        }else{
          return _buildLoadingView();
        }
      },
    );
  }

  Widget _buildLoadingView(){
    return Center(
      child: LoadingDialog.showLoadingView(),
    );
  }

  Widget _buildProductsView(List<EditAdModel> ads){
    return Flexible(
      child: CustomPullRefresh(
        controller: refreshController,
        onRefresh: ()=> myAdsCubit.setRefreshUserAds(context,refreshController),
        child: ListView.builder(
          itemCount: ads.length,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (context,index){
            AdsModel adsModel=AdsModel(
              title: ads[index].title,
              id: ads[index].id,
              lng: ads[index].lng,
              lat: ads[index].lat,
              img: ads[index].img,
              allImg: ads[index].allImg,
              checkRate: ads[index].checkRate,
              checkWishList: ads[index].checkWishList,
              countComment: ads[index].countComment,
              date: ads[index].date,
              location: ads[index].location,
              userName: ads[index].userName,
            );
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: ProductRow(index: index,model: adsModel),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'حذف',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: ()=>_buildConfirmRemoveAd(ads[index]),
                ),
                IconSlideAction(
                  caption: 'تعديل',
                  color: Colors.blueAccent,
                  icon: Icons.edit,
                  onTap: ()=>navigateTo(context,ads[index]),
                ),

              ],
            );
          },
        ),
      ),
    );
  }

  void _buildConfirmRemoveAd(EditAdModel model){
    LoadingDialog.showConfirmDialog(
        context: context,
        title: "تأكيد حذف الإعلان",
        confirm: ()=>myAdsCubit.stRemoveMyAd(context, model)
    );
  }


}




