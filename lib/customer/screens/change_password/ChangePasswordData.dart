part of 'ChangePasswordImports.dart';


class ChangePasswordData{
  final GlobalKey<FormState> formKey =new GlobalKey();
  final TextEditingController oldPassword = new TextEditingController();
  final TextEditingController newPassword = new TextEditingController();
  final TextEditingController confirm = new TextEditingController();

  void setChangePassword(BuildContext context)async{
    FocusScope.of(context).requestFocus(FocusNode());
    if(formKey.currentState.validate()){
      var result = await CustomerRepository(context).changePassword(oldPassword.text,newPassword.text);
      if(result){
        AutoRouter.of(context).pop();
      }
    }
  }

}