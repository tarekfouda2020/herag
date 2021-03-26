part of 'ResetPasswordImports.dart';



class ResetPassword extends StatefulWidget {
  final String userId;
  ResetPassword({@required this.userId});
  @override
  State<StatefulWidget> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> with ResetPasswordData {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      body: BlocBuilder<ResetPasswordCubit,ResetPasswordState>(
        bloc: resetPasswordCubit,
        builder: (context,state){
          return IgnorePointer(
            ignoring: state.showLoading,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.symmetric(vertical: 20),
                children: <Widget>[
                  HeaderLogo(),
                  _buildFormInputs(),
                  _buildConfirmButton(state.showLoading),
                ],
              ),
            ),
          );
        },
      ),
    );
  }



  Widget _buildFormInputs(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyText(
                title:tr(context,"resetPassword"),
                size: 12,
                color: MyColors.black,
                alien: TextAlign.center,
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios,size: 25,color: MyColors.primary,),
                onPressed: ()=> Navigator.of(context).pop(),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 40),
            child: Form(
                key: _formKey,

                child: Column(
                  children: [
                    LabelTextField(
                      margin: EdgeInsets.symmetric(horizontal: 10,),
                      type: TextInputType.number,
                      label: tr(context,"activeCode"),
                      isPassword: false,
                      controller: _code,
                      action: TextInputAction.next,
                      validate: (value)=> Validator(context).validateEmpty(value: value),
                    ),
                    LabelTextField(
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      type: TextInputType.text,
                      label: tr(context,"newPassword"),
                      isPassword: true,
                      controller: _new,
                      action: TextInputAction.next,
                      validate: (value)=> Validator(context).validatePassword(value: value),
                    ),
                    LabelTextField (
                      margin: EdgeInsets.symmetric(horizontal: 10,),
                      type: TextInputType.text,
                      label: tr(context,"confirmPassword"),
                      isPassword: true,
                      action: TextInputAction.done,
                      onSubmit: ()=>setForgetPassword(context,widget.userId),
                      controller: _conform,
                      validate: (value)=> Validator(context).validatePasswordConfirm(confirm: value,pass: _new.text),
                    ),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(bool showLoading){
    return Visibility(
      child: InkWell(
        onTap: ()=>setForgetPassword(context,widget.userId),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
            color: MyColors.primary,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: MyText(
            title: "${tr(context,"send")}",
            size: 12,
            color: Colors.white,
          ),
        ),
      ),
      visible: !showLoading,
      replacement: SpinKitDualRing(
        color: MyColors.primary,
        size: 30.0,
      ),
    );
  }

}
