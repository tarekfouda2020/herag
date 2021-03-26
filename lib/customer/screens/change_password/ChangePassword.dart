part of 'ChangePasswordImports.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword>  with ChangePasswordData {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "تغيير رمز المرور", con: context),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  LabelTextField(
                    controller: oldPassword,
                    label: "رمز المرور القديمة",
                    isPassword: true,
                    margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    action: TextInputAction.next,
                    validate: (value)=>Validator(context).validateEmpty(value: value),
                    type: TextInputType.text,
                  ),
                  LabelTextField(
                    controller: newPassword,
                    label: "رمز المرور الجديدة",
                    isPassword: true,
                    margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    action: TextInputAction.next,
                    validate: (value)=>Validator(context).validatePassword(value: value),
                    type: TextInputType.text,
                  ),
                  LabelTextField(
                    controller: confirm,
                    label: "تاكيد رمز المرور",
                    isPassword: true,
                    margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    action: TextInputAction.done,
                    validate: (value)=>Validator(context).validatePasswordConfirm(confirm: value,pass: newPassword.text),
                    type: TextInputType.text,
                    onSubmit: ()=>setChangePassword(context),
                  ),
                ],
              ),
            ),
          ),

          DefaultButton(
            onTap: ()=>setChangePassword(context),
            title: "حفظ التعديلات",
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          ),
        ],
      ),
    );
  }
}
