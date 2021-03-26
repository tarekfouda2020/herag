part of 'FollowerAdsImports.dart';

class FollowerAds extends StatefulWidget {
  @override
  _FollowerAdsState createState() => _FollowerAdsState();
}

class _FollowerAdsState extends State<FollowerAds> {

  final FollowerAdsCubit followerAdsCubit=new FollowerAdsCubit();

  @override
  void initState() {
    followerAdsCubit.fetchUserAds(context,refresh: false);
    followerAdsCubit.fetchUserAds(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowerAdsCubit,FollowerAdsState>(
      bloc: followerAdsCubit,
      builder: (context,state){
        if(state is FollowerAdsUpdated){
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


  Widget _buildProductsView(List<AdsModel> ads){
    return Flexible(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: ads.length,
        itemBuilder: (context,index){
          return _buildProductSlideView(index: index,model: ads[index],);
        },
      ),
    );
  }

  Widget _buildProductSlideView({AdsModel model, int index}){
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ProductRow(index: index,model: model),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Remove',
          color: Colors.red,
          icon: Icons.delete,
          onTap: ()=>_buildConfirmRemoveFollowAd(model),
        ),
      ],
    );
  }


  Widget _buildLoadingView(){
    return Center(
      child: LoadingDialog.showLoadingView(),
    );
  }

  void _buildConfirmRemoveFollowAd(AdsModel model){
    LoadingDialog.showConfirmDialog(
        context: context,
        title: "تأكيد حذف الاعلان من المتابعة",
        confirm: ()=>followerAdsCubit.removeFollowAd(context, model)
    );
  }

}
