part of 'EditDetailsImports.dart';

class EditOfferDetails extends StatefulWidget {
  final UpdateAdModel model;
  final AdsDataModel adModel;
  const EditOfferDetails({@required this.model,@required this.adModel});

  @override
  _AddOfferDetailsState createState() => _AddOfferDetailsState();
}

class _AddOfferDetailsState extends State<EditOfferDetails> with EditDetailsData {


  @override
  void initState() {
    title.text=widget.adModel.title;
    if(widget.adModel.fromAppOrNo){
      List<dynamic> descList = json.decode(widget.adModel.description);
      descList.forEach((element) {
        desc.text+=element+" \n";
      });
    }else{
      desc.text=widget.adModel.description;
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(title: "تفاصيل الإعلان", con: context),
      body: GestureDetector(
        onTap: ()=> FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          children: [
            _buildAddImagesView(),
            _buildInputFields(),
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
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(
          children: [

            Form(
              key: formKey,
              child: LabelTextField(
                margin: EdgeInsets.symmetric(vertical: 5),
                controller: title,
                action: TextInputAction.next,
                label: " عنوان الإعلان",
                validate: (value)=>Validator(context).validateEmpty(value: value),
              ),
            ),

            BlocBuilder<MapReplyCubit,MapReplyState>(
              bloc: mapReplyCubit,
              builder: (context,state){
                return Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(value: state.showMap, onChanged:(val)=> mapReplyCubit.onMapChanged()),
                        SizedBox(width: 5,),
                        MyText(title: "اظهار الموقع علي الخريطة",size: 10,color: MyColors.blackOpacity,)
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(value: state.closeReply, onChanged: (val)=> mapReplyCubit.onReplyChanged()),
                        SizedBox(width: 5,),
                        MyText(title: "اخفاء الرد علي التعليقات",size: 10,color: MyColors.blackOpacity,)
                      ],
                    ),
                  ],
                );
              },
            ),

          ],
        ),
      );
  }



  Widget _buildDescInput(){
    return RichTextFiled(
      controller: desc,
      action: TextInputAction.newline,
      type: TextInputType.multiline,
      height: 200,
      max: 15,
      min: 12,
      label: "وصف للاعلان",
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
    );
  }




}
