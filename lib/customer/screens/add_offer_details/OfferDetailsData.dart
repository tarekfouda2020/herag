part of 'OfferDetailsImports.dart';

class OfferDetailsData{
  final GlobalKey<ScaffoldState> scaffold =new GlobalKey();
  final GlobalKey<FormState> formKey=new GlobalKey();
  final TextEditingController title=new TextEditingController();
  final TextEditingController price=new TextEditingController();
  final TextEditingController phone=new TextEditingController();
  final TextEditingController desc=new TextEditingController();
  final GlobalKey<DropdownSearchState<Category>> dept=new GlobalKey();
  final CatsInputsCubit catsInputsCubit=new CatsInputsCubit();
  final HeaderCubit headerCubit=new HeaderCubit();
  final GroupCubit groupCubit=new GroupCubit();
  final DescCubit descCubit=new DescCubit();
  final AdsPhoneCubit adsPhoneCubit=new AdsPhoneCubit();
  String catId;
  String lastCat;

  List<DropDownModel> get replyOptions =>[
    DropDownModel(name: "نعم",id: 1),
    DropDownModel(name: "لا",id: 0),
  ];

  DropDownModel reply=DropDownModel(name: "نعم",id: 1);

  void setDeptChanged(Category model,BuildContext context)async{
    clearChildrenData();
    catsInputsCubit.onCatsInputClear();
    if(model!=null){
      catId=model.id.toString();
      // model.list.forEach((element) {
      //   element.selected=false;
      // });
      getPropertiesList(context);
      var children = await context.read<MyDatabase>().selectChildrenCatsAsync(model.id);
      if(children.length>0){
        catsInputsCubit.onCatsInputsUpdated(List.from([model]));
      }else{
        lastCat=model.id.toString();
      }
    }
  }

  void setChangeReplyOption(DropDownModel model){
    reply = model;
  }

  void setCatChanged(Category model,int index,BuildContext context)async{
    catsInputsCubit.onCatsInputClearAbove(index+1);
    if(model!=null){
      catId=model.id.toString();
      var children = await context.read<MyDatabase>().selectChildrenCatsAsync(model.id);
      if(children.length>0){
        catsInputsCubit.onCatsInputAdded(model);
      }else{
        lastCat=model.id.toString();
      }
    }
  }

  void getPropertiesList(BuildContext context)async{
    List<SpecificationHeaderModel> data=await CustomerRepository(context).getOffersPropertyData(catId);
    headerCubit.onHeaderUpdated(data);
  }

  void clearChildrenData()async{
    headerCubit.onHeaderUpdated([]);
    groupCubit.onGroupUpdated([]);
    descCubit.onDescListChanged([]);
  }

  void selectSpecificHeader(int selected,int index,SpecificationGroupModel model){
    var headers = headerCubit.state.headers;
    groupCubit.state.specifications.removeWhere((element) => headers[index].groupList.contains(element));
    headers[index].selectedId=selected;
    groupCubit.state.specifications.add(model);
    groupCubit.onGroupUpdated(groupCubit.state.specifications);
    //// groupCubit.onGroupUpdated(model.specificationsList);
    List<CatPropertyModel> props=descCubit.state.descriptions;
    //// props.removeWhere((element) =>element.header==headers[index].id||element.type!=0);
    props.removeWhere((element) =>element.header==headers[index].id);
    props.add(CatPropertyModel(title: headers[index].title,value: model.name,type: 0,header: headers[index].id));
    headers[index].groupList.forEach((element) {
      element.selectedId=null;
      element.specificationsList.forEach((item) {
        item.selectedId=null;
        item.value=0;
      });
    });
    headerCubit.onHeaderUpdated(headers);
    descCubit.onDescListChanged(props);


  }

  void selectSpecificGroup(int selected,int index,PropertyModel model,int groupIndex){
    var groups = groupCubit.state.specifications;
    groups[index].specificationsList[groupIndex].selectedId=selected;
    groupCubit.onGroupUpdated(groups);
    List<CatPropertyModel> props=descCubit.state.descriptions;
    var exist= props.where((element) => element.title==groups[index].specificationsList[groupIndex].name).toList();
    if(exist.length>0){
      props.remove(exist.first);
    }
    props.add(CatPropertyModel(title: groups[index].specificationsList[groupIndex].name,value: model.name,type: groups[index].specificationsList[groupIndex].type));
    descCubit.onDescListChanged(props);

  }

  void changePropSlider(double value,int index, int groupIndex){
    var groups = groupCubit.state.specifications;
    groups[index].specificationsList[groupIndex].value=value.toInt();
    groupCubit.onGroupUpdated(groups);
    List<CatPropertyModel> props=descCubit.state.descriptions;
    var exist= props.where((element) => element.title==groups[index].specificationsList[groupIndex].name).toList();
    if(exist.length>0){
      props.remove(exist.first);
    }
    props.add(CatPropertyModel(title: groups[index].specificationsList[groupIndex].name,value: value.toString(), type: groups[index].specificationsList[groupIndex].type));
    descCubit.onDescListChanged(props);

  }

  void selectDropDownProp(int index,PropertyModel model,int groupIndex){
    var groups = groupCubit.state.specifications;
    List<CatPropertyModel> props=descCubit.state.descriptions;
    var exist= props.where((element) => element.title==groups[index].specificationsList[groupIndex].name).toList();
    if(exist.length>0){
      props.remove(exist.first);
    }
    if(model!=null){
      var groups = groupCubit.state.specifications;
      groups[index].specificationsList[groupIndex].selectedId=model.id;
      groupCubit.onGroupUpdated(groups);
      props.add(CatPropertyModel(title: groups[index].specificationsList[groupIndex].name,value: model.name,type: groups[index].specificationsList[groupIndex].type));
      descCubit.onDescListChanged(props);
    }else{
      descCubit.onDescListChanged(props);
    }

  }

  void changePhoneState(value){
    adsPhoneCubit.onUpdatePhone(showPhone: value);
  }

  void changePriceState(value){
    adsPhoneCubit.onUpdatePrice(showPrice: value);
  }

  void setAddOffer(BuildContext context,AddAdsModel model){
    String valid =Validator(context).validatePhone(value: phone.text);
    if(valid !=null&&adsPhoneCubit.state.showPhone){
      LoadingDialog.showSimpleToast("قم بادخال رقم الجوال");
      return;
    }
    if(title.text.isEmpty){
      LoadingDialog.showSimpleToast("قم بادخال عنوان للإعلان");
      return;
    }
    if(price.text.isEmpty&&adsPhoneCubit.state.showPrice){
      LoadingDialog.showSimpleToast("قم بادخال سعر للإعلان");
      return;
    }
    if(lastCat==null){
      LoadingDialog.showSimpleToast("ادخل القسم التابع للإعلان");
      return;
    }
    List<String> props=descCubit.state.descriptions.map((e) => "${e.title} ${e.value}").toList();
    model.title=title.text;
    model.fkCat=lastCat;
    model.phone=phone.text;
    model.price=price.text;
    model.fromAppOrNo=true.toString();
    model.showPhone=(!adsPhoneCubit.state.showPhone).toString();
    model.determinePrice=(!adsPhoneCubit.state.showPrice).toString();
    model.lang=context.read<LangCubit>().state.locale.languageCode;
    model.description= json.encode(props);
    model.notes= desc.text;
    model.closeReply = (reply.id==1);

    print(model.toJson());
    CustomerRepository(context).setAddOffer(model).then((value) {
      if(value){
        AutoRouter.of(context).popUntilRouteWithName(HomeRoute.name);
        AutoRouter.of(context).push(AddOfferSuccessRoute());
      }
    });


  }

}