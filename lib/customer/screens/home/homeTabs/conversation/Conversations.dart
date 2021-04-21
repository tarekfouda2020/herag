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
    conversationCubit.fetchData(context, refresh: false);
    conversationCubit.fetchData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserCubit>().state.model;
    return Scaffold(
      appBar: DefaultAppBar(
        con: context,
        title: tr(context, "chats"),
        leading: Container(),
      ),
      body: BlocBuilder<ConversationCubit, ConversationState>(
        bloc: conversationCubit,
        builder: (context, state) {
          if (state is ConversationUpdated) {
            if (state.lst.length > 0) {
              return _buildChatUsersList(state.lst, user);
            } else {
              return _buildNoDataView();
            }
          } else {
            return _buildLoadingView();
          }
        },
      ),
    );
  }

  _buildChatUsersList(List<ChatModel> lst, UserModel user) {
    return ListView.builder(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: lst.length,
      itemBuilder: (con, index) {
        return _buildChatItem(
          model: lst[index],
          user: user,
          index: index,
        );
      },
    );
  }

  _buildLoadingView() {
    return Center(
      child: LoadingDialog.showLoadingView(),
    );
  }

  _buildNoDataView() {
    return Center(
      child: MyText(
        title: tr(context, "noChats"),
        size: 12,
        color: MyColors.blackOpacity,
      ),
    );
  }

  _buildChatItem({int index, ChatModel model, UserModel user}) {
    return InkWell(
      onTap: () => navigateToChat(context, model, user),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: index.isEven ? MyColors.white : MyColors.greyWhite,
              border: Border(
                  bottom: BorderSide(color: MyColors.greyWhite, width: 1))),
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
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  MyText(
                    title: model.userName,
                    size: 10,
                    color: MyColors.black,
                  ),
                  Spacer(),
                  MyText(
                    title: model.date,
                    size: 8,
                    color: MyColors.blackOpacity,
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: MyText(
                        title: model.lastMessage,
                        size: model.count > 0 ? 12 : 8,
                        color: model.count > 0
                            ? MyColors.black
                            : MyColors.blackOpacity,
                      ),
                    ),
                    Offstage(
                      offstage: model.count == 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.red,
                                  spreadRadius: 1,
                                  blurRadius: 1)
                            ]),
                        // child: Text("${model.count}",style: TextStyle(color: MyColors.white,fontSize: 10),),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
