part of 'OfferDetailsImports.dart';

class AddOfferDetails extends StatefulWidget {
  final AddAdsModel model;

  const AddOfferDetails({@required this.model});

  @override
  _AddOfferDetailsState createState() => _AddOfferDetailsState();
}

class _AddOfferDetailsState extends State<AddOfferDetails> with OfferDetailsData {


  @override
  void initState() {
    // setDeptChanged(widget.model.category,context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(title: "تفاصيل الإعلان", con: context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            _buildAddImagesView(),
            _buildInputFields(),
            _buildListHeader(),
            _buildListSpecification(),
            _buildDescInput(),
            DefaultButton(
                margin: EdgeInsets.all(20),
                title: "استمرار",
                onTap: ()=>setAddOffer(context,widget.model)
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildAddImagesView(){
    return Container(
      color: MyColors.greyWhite,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        spacing: 10,
        children: List.generate(widget.model.images.length, (index) {
          return  Container(
            width: 90,
            height: 80,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: FileImage(widget.model.images[index]),
                  colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                  fit: BoxFit.fill
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildInputFields(){
    return Form(
      key: formKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(
          children: [
            //advert title
            Row(
              children: [
                Icon(Icons.edit,size: 20,color: MyColors.blackOpacity,),
                SizedBox(width: 5,),
                MyText(title: "عنوان الإعلان",size: 10,color: MyColors.blackOpacity,)
              ],
            ),
            LabelTextField(
              margin: EdgeInsets.symmetric(vertical: 5),
              controller: title,
              action: TextInputAction.next,
              label: "ادخل عنوان الإعلان",
              validate: (value)=>Validator(context).validateEmpty(value: value),
            ),
            //advert price
            Row(
              children: [
                Icon(Icons.swap_vert_circle_outlined,size: 20,color: MyColors.blackOpacity,),
                SizedBox(width: 5,),
                MyText(title: "سعر الإعلان",size: 10,color: MyColors.blackOpacity,)
              ],
            ),
            //advert dept
            Row(
              children: [
                Icon(Icons.menu_open,size: 20,color: MyColors.blackOpacity,),
                SizedBox(width: 5,),
                MyText(title: "القسم",size: 10,color: MyColors.blackOpacity,)
              ],
            ),
            DropdownTextField<Category>(
              dropKey: dept,
              label: "اسم القسم",
              useName: true,
              selectedItem: widget.model.category,
              // showSelectedItem: true,
              margin: EdgeInsets.symmetric(vertical: 5),
              validate: (value)=>Validator(context).validateDropDown<Category>(model: value),
              finData: (filter)async=>await context.read<MyDatabase>().selectParentCatsWithoutMainAsync(),
              onChange: (model)=>setDeptChanged(model,context,),
            ),
            _buildCatsInputs(),
            //advert price
            BlocBuilder<AdsPhoneCubit,AdsPhoneState>(
              bloc: adsPhoneCubit,
              builder: (context,state){
                return Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(value: state.showPrice, onChanged: changePriceState),
                        SizedBox(width: 5,),
                        MyText(title: "هل ترغب بتحديد السعر ؟",size: 10,color: MyColors.blackOpacity,)
                      ],
                    ),
                    Offstage(
                      offstage: !state.showPrice,
                      child: LabelTextField(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        controller: price,
                        type: TextInputType.number,
                        label: "ادخل سعر الإعلان",
                        action: TextInputAction.done,
                        validate: (value)=>Validator(context).validateEmpty(value: value),
                      ),
                    )
                  ],
                );
              },
            ),
            //contact phone
            BlocBuilder<AdsPhoneCubit,AdsPhoneState>(
              bloc: adsPhoneCubit,
              builder: (context,state){
                return Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(value: state.showPhone, onChanged: changePhoneState),
                        SizedBox(width: 5,),
                        MyText(title: "هل ترغب بتحديد رقم الجوال ؟",size: 10,color: MyColors.blackOpacity,)
                      ],
                    ),
                    Offstage(
                      offstage: !state.showPhone,
                      child: LabelTextField(
                        margin: EdgeInsets.only(bottom: 10),
                        controller: phone,
                        action: TextInputAction.done,
                        type: TextInputType.phone,
                        label: "ادخل رقم الجوال",
                        validate: (value)=>Validator(context).validateEmpty(value: value),
                      ),
                    )
                  ],
                );
              },
            ),

            DropdownTextField<DropDownModel>(
              label: "هل ترغب فى فتح التعليق ؟",
              useName: true,
              selectedItem: replyOptions.first,
              data: replyOptions,
              margin: EdgeInsets.symmetric(vertical: 10),
              validate: (value)=>Validator(context).validateDropDown<DropDownModel>(model: value),
              onChange: (model)=>setChangeReplyOption(model),
            ),


          ],
        ),
      ),
    );
  }

  Widget _buildCatsInputs(){
    return BlocBuilder<CatsInputsCubit,CatsInputsState>(
      bloc: catsInputsCubit,
      builder: (context,state){
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            children: List.generate(state.cats.length, (index) {
              var children= context.watch<MyDatabase>().selectChildrenCatsAsync(state.cats[index].id);
              return DropdownTextField<Category>(
                label: "اسم القسم الفرعي",
                useName: true,
                margin: EdgeInsets.symmetric(vertical: 10),
                validate: (value)=>Validator(context).validateDropDown<Category>(model: value),
                finData: (filter)async=>children,
                onChange: (model)=>setCatChanged(model, index,context,),
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildListHeader(){
    return BlocBuilder<HeaderCubit,HeaderState>(
      bloc: headerCubit,
      builder: (context,state){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(state.headers.length, (index) {
              return _buildHeaderRadioGroup(state.headers[index], index);
            }),
          ),
        );
      },
    );
  }

  Widget _buildHeaderRadioGroup(SpecificationHeaderModel model,int index){
    return Container(
      child: DropdownTextField<SpecificationGroupModel>(
          label: "${model.title}",
          margin: EdgeInsets.symmetric(vertical: 10),
          validate: (value)=>Validator(context).validateDropDown<SpecificationGroupModel>(model: value),
          data: model.groupList,
          onChange: (SpecificationGroupModel model)=>selectSpecificHeader(model.id,index,model)
      ),
    );
  }

  Widget _buildListSpecification(){
    return BlocBuilder<GroupCubit,GroupState>(
      bloc: groupCubit,
      builder: (context,state){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(state.specifications.length, (index) {
              return _buildSpecificationRadioGroup(state.specifications[index], index);
            }),
          ),
        );
      },
    );
  }

  Widget _buildSpecificationRadioGroup(SpecificationGroupModel model,int index){
    return Column(
      children: List.generate(model.specificationsList.length, (position) {
        return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 5),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Row(
                  children: [
                    MyText(title: model.specificationsList[position].name,size: 11,color: MyColors.blackOpacity,),
                  ],
                ),
                _buildPropertyType(model.specificationsList[position], index,position)

              ]
          ),
        );
      }),
    );
  }

  Widget _buildPropertyType(SpecificationModel model,int index,int groupIndex){
    if(model.type==2){
      return Slider(
        value: model.value.toDouble(),
        onChanged: (val)=>changePropSlider(val,index,groupIndex,),
        min: 0,
        max: 1000,
        divisions: 100,
        activeColor: MyColors.primary,
      );
    }else if(model.type==1){
      return Column(
        children: List.generate(model.props.length, (position){
          return Row(
            children: [
              Radio(
                  value: model.props[position].id,
                  groupValue: model.selectedId,
                  onChanged: (value)=>selectSpecificGroup(value,index,model.props[position],groupIndex,)
              ),
              MyText(title: model.props[position].name,size: 9,color: MyColors.blackOpacity,)
            ],
          );
        }),
      );
    }else{
      var children=model.props.where((element) => element.id==model.selectedId).toList();
      return DropdownTextField<PropertyModel>(
        dropKey: new GlobalKey<DropdownSearchState>(),
        label: "${model.name}",
        margin: EdgeInsets.symmetric(vertical: 10),
        selectedItem: children.length>0?children.first:null,
        validate: (value)=>Validator(context).validateDropDown<PropertyModel>(model: value),
        data: model.props,
        onChange: (model)=>selectDropDownProp(index,model,groupIndex,),
      );
    }
  }


  Widget _buildDescInput(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.menu_open,size: 20,color: MyColors.black,),
              SizedBox(width: 5,),
              MyText(title: "نص الإعلان",size: 10,color: MyColors.black,)
            ],
          ),
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: MyColors.greyWhite,
                border: Border.all(color: MyColors.grey,width: 1),
                borderRadius: BorderRadius.circular(10)
            ),
            child: BlocBuilder<DescCubit,DescState>(
              bloc: descCubit,
              builder: (context,state){
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(state.descriptions.length, (index) {
                      return _buildTextItem(state.descriptions[index]);
                    }),
                  ),
                );
              },
            ),
          ),

          _buildNotesRichInput(),
        ],
      ),
    );
  }


  Widget _buildTextItem(CatPropertyModel model){
    return AutoSizeText(
      '${model.title} ${model.value}',
      style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
      maxFontSize: 12,
      minFontSize: 8,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildNotesRichInput(){
    return RichTextFiled(
      controller: desc,
      action: TextInputAction.newline,
      type: TextInputType.multiline,
      height: 150,
      max: 15,
      min: 12,
      label: "اضافة شرح",
      margin: EdgeInsets.symmetric(vertical: 20),
    );
  }



}
