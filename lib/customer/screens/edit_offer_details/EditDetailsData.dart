part of 'EditDetailsImports.dart';

class EditDetailsData{
  final GlobalKey<ScaffoldState> scaffold =new GlobalKey();
  final GlobalKey<FormState> formKey =new GlobalKey();
  final TextEditingController title=new TextEditingController();
  final TextEditingController desc=new TextEditingController();
  final MapReplyCubit mapReplyCubit =new MapReplyCubit();



  void setAddOffer(BuildContext context,UpdateAdModel model){

    if(formKey.currentState.validate()){
      model.closeReply=mapReplyCubit.state.closeReply.toString();
      model.showMap=mapReplyCubit.state.showMap.toString();
      model.lang=context.read<LangCubit>().state.locale.languageCode;
      model.description= desc.text;
      model.title=title.text;

      print(model.toJson());
      CustomerRepository(context).setEditOffer(model).then((value) {
        if(value){
          HomeMainData.pagingController.refresh();
          AutoRouter.of(context).popUntilRouteWithName( HomeRoute.name);
          AutoRouter.of(context).pushPath(EditOfferSuccessRoute.name);
        }
      });
    }

  }

}