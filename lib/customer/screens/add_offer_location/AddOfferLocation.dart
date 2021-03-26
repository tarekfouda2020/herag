part of 'AddOfferLocImports.dart';


class AddOfferLocation extends StatefulWidget {
  final AddAdsModel model;

  const AddOfferLocation({@required this.model});
  @override
  _AddOfferLocationState createState() => _AddOfferLocationState();
}

class _AddOfferLocationState extends State<AddOfferLocation> with AddOfferLocData {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      appBar: DefaultAppBar(title: "تفاصيل الإعلان", con: context),
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          _buildDropDownInputs(),
          BlocConsumer<LocationCubit,LocationState>(
            listener: (context,state){
              address.text=state.model.address;
            },
            builder: (context,state){
              return InkWellTextField(
                controller: address,
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                icon: Icon(Icons.location_pin,size: 20,color: MyColors.black,),
                label: "الموقع",
                onTab: ()=>navigateToLocationAddress(context),
              );
            },
          ),
        ],
      ),

      bottomNavigationBar: _buildNavButton(context),
    );
  }

  Widget _buildDropDownInputs(){
    return Form(
      key: formKey,
      child: Column(
        children: [
          DropdownTextField<DropDownModel>(
            label: "اسم المنطقة",
            dropKey: region,
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            onChange: setSelectRegion,
            finData: (filter)async=> await CustomerRepository(context).getRegionData(),
            validate: (value)=>Validator(context).validateDropDown<DropDownModel>(model: value),
          ),
          DropdownTextField<DropDownModel>(
            label: "اسم المدينة",
            dropKey: city,
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            onChange: setSelectCity,
            validate: (value)=>Validator(context).validateDropDown<DropDownModel>(model: value),
            finData: (filter)async=> await CustomerRepository(context).getCitiesData(regionId),
          ),
          DropdownTextField<DropDownModel>(
            label: "اسم الحي",
            dropKey: neighbor,
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            onChange: setSelectNeighbor,
            validate: (value)=>Validator(context).validateDropDown<DropDownModel>(model: value),
            finData: (filter)async=> await CustomerRepository(context).getNeighborsData(cityId),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(BuildContext context){
    return InkWell(
      onTap: ()=>navigateToAddDetails(widget.model,context),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: MyColors.primary,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20)
          ),
        ),
        alignment: Alignment.center,
        child: MyText(title: "استمرار",size: 12,color: MyColors.white,),
      ),
    );
  }

}
