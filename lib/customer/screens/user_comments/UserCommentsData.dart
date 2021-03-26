part of  'UserCommentsImports.dart';

class UserCommentsData{

  final CommentCubit commentCubit=new CommentCubit();
  final GlobalKey<FormState> formKey=new GlobalKey();
  final GlobalKey<FormState> repFormKey=new GlobalKey();
  final TextEditingController comment = new TextEditingController();
  final TextEditingController reply = new TextEditingController();

  void setAddComment(BuildContext context,String id)async{
    if(formKey.currentState.validate()){
      await commentCubit.setAddComment(context, id, comment.text);
      comment.clear();
      Navigator.pop(context);
    }
  }


}