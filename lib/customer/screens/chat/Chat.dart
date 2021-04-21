part of 'ChatImports.dart';

class Chat extends StatefulWidget {
  final String senderId;
  final String receiverId;
  final String userName;

  const Chat(
      {@required this.senderId,
      @required this.receiverId,
      @required this.userName});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with ChatData {
  @override
  void initState() {
    chatCubit.fetchData(context, widget.receiverId);
    setConnectServer(widget.senderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserCubit>().state.model;
    return Scaffold(
      appBar: DefaultAppBar(
        title: widget.userName,
        con: context,
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline_rounded,
              size: 25,
              color: MyColors.white,
            ),
            onPressed: () => _buildAddReportDialog(),
          ),
        ],
      ),
      backgroundColor: MyColors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: [_buildChatMessage(user), _buildChatInput()],
        ),
      ),
    );
  }

  Widget _buildChatMessage(UserModel user) {
    return BlocBuilder<ChatCubit, ChatState>(
      bloc: chatCubit,
      builder: (context, state) {
        return Flexible(
            child: ScrollablePositionedList.builder(
          padding: EdgeInsets.only(bottom: 10),
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          itemCount: state.messages.length,
          addAutomaticKeepAlives: true,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (context, index) {
            if (state is ChatUpdated) {
              if (user.id == state.messages[index].senderId) {
                return _buildRightMsg(state.messages[index], user);
              } else {
                return _buildLeftMsg(state.messages[index]);
              }
            } else {
              return Expanded(
                child: Center(
                  child: LoadingDialog.showLoadingView(),
                ),
              );
            }
          },
        ));
      },
    );
  }

  Widget _buildRightMsg(MessageModel model, UserModel user) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            title: user.userName,
            size: 8,
            color: MyColors.blackOpacity,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              minHeight: 30,
              maxWidth: MediaQuery.of(context).size.width * .7,
              minWidth: MediaQuery.of(context).size.width * .4,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8))),
              child: MyText(
                title: model.message,
                size: 9,
                color: MyColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLeftMsg(MessageModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => AutoRouter.of(context).push(UserProductsRoute(
                userId: model.receiverId, userName: widget.userName)),
            child: MyText(
              title: widget.userName,
              size: 8,
              color: MyColors.blackOpacity,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              minHeight: 30,
              maxWidth: MediaQuery.of(context).size.width * .7,
              minWidth: MediaQuery.of(context).size.width * .4,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              decoration: BoxDecoration(
                  color: MyColors.greyWhite,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8))),
              child: MyText(
                title: model.message,
                size: 9,
                color: MyColors.blackOpacity,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return ChatTextField(
      controller: _msg,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      label: tr(context, "writeMsg"),
      action: TextInputAction.newline,
      submit: () =>
          sendChatMessage(widget.receiverId, widget.senderId, context),
    );
  }

  void _buildAddReportDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: MyColors.white,
          titlePadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          title: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: MyColors.primary,
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  title: tr(context, "report"),
                  size: 12,
                  color: Colors.white,
                ),
                InkWell(
                  child: Icon(
                    Icons.close,
                    size: 25,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).pop(),
                )
              ],
            ),
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: RichTextFiled(
                    controller: report,
                    height: 100,
                    label: tr(context, "writeReason"),
                    max: 10,
                    min: 6,
                    submit: (value) => setAddReport(context, widget.receiverId),
                    validate: (value) =>
                        Validator(context).validateEmpty(value: value),
                  ),
                ),
                DefaultButton(
                    title: tr(context, "send"),
                    onTap: () => setAddReport(context, widget.receiverId))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _hubConnection.invoke("DisConnect", args: <Object>["${widget.senderId}"]);
    super.dispose();
  }
}
