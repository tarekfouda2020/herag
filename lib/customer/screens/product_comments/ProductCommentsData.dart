part of  'ProCommentsImports.dart';

class ProductCommentsData{

  final CommentCubit commentCubit=new CommentCubit();
  final GlobalKey<FormState> formKey=new GlobalKey();
  final GlobalKey<FormState> repFormKey=new GlobalKey();
  final TextEditingController comment = new TextEditingController();
  final TextEditingController reply = new TextEditingController();

  void setAddComment(BuildContext context,int id)async{
    if(formKey.currentState.validate()){
      await commentCubit.setAddComment(context, id, comment.text);
      Navigator.pop(context);
      HomeMainData.pagingController.refresh();
    }
  }

  void setAddReply(BuildContext context,int id)async{
    if(repFormKey.currentState.validate()){
     await commentCubit.setAddReply(context, id, reply.text);
      Navigator.pop(context);
    }
  }

}