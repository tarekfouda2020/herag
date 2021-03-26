part of 'CallUsImports.dart';


class CallUsData {
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey();
  GlobalKey<FormState> _formKey = new GlobalKey();

  final GlobalKey<DropdownSearchState<DropDownModel>> reason= new GlobalKey();
  TextEditingController msg = new TextEditingController();
  TextEditingController callFile = new TextEditingController();

  final CallImageCubit callImageCubit = new CallImageCubit();
  final CallSocialCubit callSocialCubit=new CallSocialCubit();

  String reasonId;

  void setSelectReason(DropDownModel model) {
    reasonId = model != null ? model.id.toString() : null;
  }

  void setCallFile(FileType type,BuildContext context) async {
    var file = await Utils.getFile();
    if (file != null) {
      callImageCubit.onUpdateFile(file);
      Navigator.of(context).pop();
    }
  }

  void setContactUs(BuildContext context) async {
    var result = await CustomerRepository(context)
        .contactUs(msg.text, reasonId, callImageCubit.state.file);
    if(result){
      reasonId="";
      msg.text="";
      callFile.text="";
      callImageCubit.onUpdateFile(null);
      reason.currentState.changeSelectedItem(null);
    }
  }
}
