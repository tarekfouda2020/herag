part of 'ConversationImports.dart';

class Conversations extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const Conversations({@required this.scaffold});
  @override
  _ConversationsState createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> with ConversationData {


  @override
  void initState() {
    conversationCubit.fetchData(context,refresh: false);
    conversationCubit.fetchData(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserCubit>().state.model;
    return Scaffold(
      appBar: DefaultAppBar(
        con: context,title: "المحادثات",
        leading: Container(),
      ),
      body: BlocBuilder<ConversationCubit,ConversationState>(
        bloc: conversationCubit,
        builder: (context,state){
          if(state is ConversationUpdated){
            if(state.lst.length>0){
              return _buildChatUsersList(state.lst,user);
            }else{
              return _buildNoDataView();
            }
          }else{
            return _buildLoadingView();
          }
        },
      ),
    );
  }

  _buildChatUsersList(List<ChatModel> lst,UserModel user){
    return ListView.builder(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: lst.length,
      itemBuilder: (con,index){
        return _buildChatItem(model: lst[index],user: user,index: index,);
      },

    );
  }

  _buildLoadingView(){
    return Center(
      child: LoadingDialog.showLoadingView(),
    );
  }

  _buildNoDataView(){
    return Center(
      child: MyText(title: "لا توجد محادثات",size: 12,color: MyColors.blackOpacity,),
    );
  }

  _buildChatItem({int index,ChatModel model,UserModel user}){
    return InkWell(
      onTap: ()=>AutoRouter.of(context).push(ChatRoute(receiverId: model.userId,userName: model.userName,senderId: user.id)
      ),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          decoration: BoxDecoration(
              color: index.isEven?MyColors.white:MyColors.greyWhite,
              border: Border(
                  bottom: BorderSide(color: MyColors.greyWhite,width: 1)
              )
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CachedImage(
                    url: model.image,
                    width: 40,
                    height: 40,
                    haveRadius: false,
                    fit: BoxFit.cover,
                    boxShape: BoxShape.circle,
                  ),                    SizedBox(width: 5,),
                  MyText(title: model.userName ,size: 10,color: MyColors.black,),
                  Spacer(),
                  MyText(title: model.date ,size: 8,color: MyColors.blackOpacity,),

                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    MyText(
                      title: model.lastMessage,
                      size: 8,
                      color: MyColors.blackOpacity,
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

}

