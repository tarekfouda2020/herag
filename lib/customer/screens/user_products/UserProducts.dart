part of  'UserProductsImports.dart';


class UserProducts extends StatefulWidget {
  final String userId;
  final String userName;
  const UserProducts({@required this.userId,@required this.userName});
  @override
  _UserProductsState createState() => _UserProductsState();
}

class _UserProductsState extends State<UserProducts> with UserProductsData {

  @override
  void initState() {
    userAdsCubit.fetchUserAds(context, widget.userId,addOwnerCubit,refresh: false);
    userAdsCubit.fetchUserAds(context, widget.userId,addOwnerCubit);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserCubit>().state.model;
    return Scaffold(
      appBar: DefaultAppBar(title: widget.userName, con: context),
      backgroundColor: MyColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderView(user),

          _buildProductContainer(),
        ],
      ),
    );
  }

  Widget _buildHeaderView(UserModel user){
    return BlocBuilder<AddOwnerCubit,AddOwnerState>(
      bloc: addOwnerCubit,
      builder: (context,state){
        if(state is AddOwnerUpdated){
          print(state.model.toJson());
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CachedImage(
                      url: state.model.imgProfile,
                      width: 40,
                      height: 40,
                      haveRadius: false,
                      fit: BoxFit.cover,
                      boxShape: BoxShape.circle,
                    ),
                  ),
                  MyText(title: state.model.userName ,size: 10,color: MyColors.black,),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: RatingBar.builder(
                      initialRating: state.model.rate.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      updateOnDrag: false,
                      ignoreGestures: true,
                      itemCount: 5,
                      itemSize: 16,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(title: "مشترك  ${state.model.publishDate}" ,size: 8,color: MyColors.blackOpacity,),
                    TitleButton(
                      padding: EdgeInsets.all(0),
                      iconData: Icons.chat,
                      title: "التعليقات",
                      onTap: ()=> navigateToComments(context,state.model),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton.icon(
                    onPressed: ()=> navigateToChat(context,widget.userId,widget.userName,user),
                    icon: Icon(Icons.mail,size: 20,color: MyColors.black,),
                    label: MyText(title: "مراسلة",size: 10,color: MyColors.black,),
                    color: Colors.white,
                    elevation: 0,
                  ),
                  TitleButton(
                      iconData: Icons.wifi,
                      title: "متابعة",
                      iconColor: state.model.showFollow?MyColors.primary:Colors.black87,
                      onTap: ()=>setAddUserToFollowers(context,widget.userId)
                  ),

                ],
              ),
              Visibility(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TitleButton(
                        padding: EdgeInsets.only(bottom: 10),
                        iconData: Icons.star,
                        iconColor: MyColors.black,
                        title: "تقييم المستخدم",
                        onTap: ()=>_buildRateUserDialog(context),
                      ),
                    ],
                  ),
                ),
                visible: !state.model.showRate,
              ),
            ],
          );
        }else{
          return Container();
        }
      },
    );
  }

  Widget _buildProductContainer(){
    return Flexible(
      child: BlocBuilder<UserAdsCubit,UserAdsState>(
        bloc: userAdsCubit,
        builder: (context,state){
          if(state is UserAdsUpdated){
            if(state.ads.length>0){
              return _builtProductsListView(state.ads);
            }else{
              return Center(
                child: MyText(title: "لايوجد بيانات",size: 12,color: MyColors.blackOpacity,),
              );
            }
          }else{
            return _buildLoadingView();
          }

        },
      ),
    );
  }

  Widget _buildLoadingView(){
    return Center(
      child: LoadingDialog.showLoadingView()
    );
  }

  Widget _builtProductsListView(List<AdsModel> products ){
    return CustomPullRefresh(
      controller: refreshController,
      onRefresh: ()=>userAdsCubit..setRefreshUserAds(context, widget.userId,refreshController),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: products.length,
        itemBuilder: (context,index){
          return ProductRow(index: index,model: products[index],);
        },
      ),
    );
  }


  void _buildRateUserDialog(BuildContext context){
    showCupertinoDialog(
      context: context,
      builder: (context){
        return  AlertDialog(
          backgroundColor: MyColors.white,
          titlePadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          title: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: MyColors.primary,
                borderRadius: BorderRadius.circular(4)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(title: "تقييم",size: 12,color: Colors.black87,),
                InkWell(
                  child: Icon(Icons.close,size: 25,color: Colors.black87,),
                  onTap: ()=>Navigator.of(context).pop(),
                )
              ],
            ),
          ),

          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<RateUserCubit,RateUserState>(
                  bloc: rateUserCubit,
                  builder: (context,state){
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: RatingBar.builder(
                        initialRating: state.rate,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        updateOnDrag: false,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) => rateUserCubit.onUpdateRateValue(rating),
                      ),
                    );
                  },
                ),

                DefaultButton(title: "ارسال", onTap: ()=>setUserRate(context,widget.userId,addOwnerCubit))
              ],
            ),
          ),

        );
      },
    );
  }


}






