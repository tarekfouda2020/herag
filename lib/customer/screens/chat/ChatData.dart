part of 'ChatImports.dart';

class ChatData{

  final GlobalKey<FormState> formKey=new GlobalKey();
  final TextEditingController _msg=new TextEditingController();
  final TextEditingController report=new TextEditingController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  final ChatCubit chatCubit =new ChatCubit();
  HubConnection _hubConnection;
  int count=0;


  void setConnectServer(String userId)async {
    itemPositionsListener.itemPositions.addListener(() {
      if(chatCubit.state.messages.length!=count){
        itemScrollController.jumpTo(index: chatCubit.state.messages.length-1);
        count=chatCubit.state.messages.length;
      }
    });
    _hubConnection = HubConnectionBuilder().withUrl(MainData.chatUrl).build();
    await _hubConnection.start();
    _hubConnection.onclose((error) => print("error when connect"));
    _hubConnection.on("receiveMessage", _handleIncomingChatMessage);
    _hubConnection.on("connected", _handleConnectedUsers);
    _hubConnection.on("disconnected", _handleDisConnectedUser);
    connectToServer(userId);
  }

  void connectToServer(String userId)async{
    List<Object> _args = ["$userId"];
    await _hubConnection.invoke("Connect", args: _args);
  }

  void _handleConnectedUsers(List<Object> args) {
    print(args[0]);
  }

  void _handleDisConnectedUser(List<Object> args) {
    print(args[0]);
  }

  void _handleIncomingChatMessage(List<Object> args) {
    print(args);
    MessageModel msg = MessageModel.fromMap(args[0]);
    _updateAndMoveDown(msg);
  }

  void _updateAndMoveDown(MessageModel msg){
    chatCubit.state.messages.add(msg);
    chatCubit.onUpdateMessages(chatCubit.state.messages);
    // itemScrollController.jumpTo(index: chatCubit.state.messages.length-1);
  }

  void sendChatMessage(String receiverID,String userId,BuildContext context) async {
    if (_msg.text.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    MessageModel msg = MessageModel(
        date: "",
        id: chatCubit.state.messages.length,
        message: _msg.text,
        receiverId: receiverID,
        senderId: userId
    );
    List<Object> _args = ["$userId", "$receiverID", "${_msg.text}",];
    await _hubConnection.invoke("SendMessage", args: _args);
    _msg.text="";
    _updateAndMoveDown(msg);
  }

  void setAddReport(BuildContext context,String id)async{
    if(formKey.currentState.validate()){
      var result = await CustomerRepository(context).addUserReport("$id", report.text);
      if(result){
        report.text="";
        Navigator.pop(context);
      }
    }
  }

}