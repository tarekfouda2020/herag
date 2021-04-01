part of 'ConversationImports.dart';


class ConversationData{

  final ConversationCubit conversationCubit =new ConversationCubit();
  navigateToChat(BuildContext context,ChatModel model,UserModel user)async{
    await AutoRouter.of(context).push(ChatRoute(receiverId: model.userId,userName: model.userName,senderId: user.id));
    conversationCubit.fetchData(context);
  }
}