part of 'FollowerUsersImports.dart';



class FollowedUsers extends StatefulWidget {
  @override
  _FollowedUsersState createState() => _FollowedUsersState();
}

class _FollowedUsersState extends State<FollowedUsers> {

  final FollowerUserCubit followerUserCubit=new FollowerUserCubit();

  @override
  void initState() {
    followerUserCubit.fetchFollowedUsers(context,refresh: false);
    followerUserCubit.fetchFollowedUsers(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowerUserCubit,FollowerUserState>(
      bloc: followerUserCubit,
      builder: (context,state){
        if(state is FollowerUserUpdated){
          if(state.followers.length>0){
            return _buildUsersListView(state.followers);
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

  Widget _buildUsersListView(List<UserFollowerModel> users){
    return ListView.builder(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemCount: users.length,
      itemBuilder: (context,int index){
        return _buildUserView(users[index]);
      },
    );
  }

  Widget _buildUserView(UserFollowerModel model){
    return AnimationContainer(
      scale: true,
      child: InkWell(
        onTap: ()=>AutoRouter.of(context).push(UserProductsRoute(userId: model.fKUserFollow,userName: model.userName)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: MyColors.greyWhite,
                    blurRadius: 1.2,
                    spreadRadius: 1.2
                )
              ]
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person_outline,size: 20,color: MyColors.black,),
                        SizedBox(width: 5,),
                        MyText(title: model.userName ,size: 10,color: MyColors.black,),
                      ],
                    ),
                    MyText(title:model.date,size: 10,color: MyColors.blackOpacity,)
                  ],
                ),
              ),
              RaisedButton(
                onPressed: ()=>_buildConfirmRemoveFollowUser(model),
                child: MyText(title: "الغاء المتابعة",size: 10,color: MyColors.white,),
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingView(){
    return Center(
      child: LoadingDialog.showLoadingView(),
    );
  }

  void _buildConfirmRemoveFollowUser(UserFollowerModel model){
    LoadingDialog.showConfirmDialog(
        context: context,
        title: "تأكيد حذف المستخدم من المتابعة",
        confirm: ()=>followerUserCubit.removeFollowUser(context, model)
    );
  }


}

