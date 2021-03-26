part of 'BankPaymentImports.dart';


class BankPaymentData{

  final GlobalKey<FormState> formKey = new GlobalKey();

  final TextEditingController name = new TextEditingController();
  final TextEditingController number = new TextEditingController();
  final TextEditingController adNumber = new TextEditingController();
  final TextEditingController ipanNumber = new TextEditingController();
  final TextEditingController notes = new TextEditingController();
  final TextEditingController price = new TextEditingController();
  final TextEditingController img = new TextEditingController();

  final PayCubit payCubit =new PayCubit();

  String bankId;

  setSelectBank(BankModel model){
    if(model!=null){
      bankId=model.id.toString();
    }
  }

  void setImage()async{
    var image = await Utils.getImage();
    if(image!=null)
      payCubit.onUpdatePayImage(image);
  }

  void addPayment(BuildContext context)async{
    if(payCubit.state.image==null){
      LoadingDialog.showSimpleToast("اضف صورة الايصال");
      return ;
    }
    if(formKey.currentState.validate()){
      AddPayModel model = new AddPayModel(
          lang: context.read<LangCubit>().state.locale.languageCode,
          image: payCubit.state.image,
          price: price.text,
          accountNumber: number.text,
          adsNumber: adNumber.text,
          fKBank: bankId,
          notes: notes.text,
          ipan: ipanNumber.text,
          transferName: name.text,
          type: "1"
      );
      var result = await CustomerRepository(context).addPayment(model);
      if(result){
        payCubit.onUpdatePayImage(null);
        img.text=price.text=adNumber.text=name.text=number.text=notes.text="";
      }
    }
  }

}