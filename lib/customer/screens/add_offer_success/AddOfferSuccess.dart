part of 'OfferSuccessImports.dart';

class AddOfferSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Spacer(),
          Image(image: AssetImage(Res.success),width: 150,height: 150,),
          SizedBox(height: 15,),
          MyText(title: tr(context,"adsAddedSuccessfully"),size: 12,color: MyColors.white,),
          Spacer(),
          DefaultButton(
              margin: EdgeInsets.all(20),
              title: tr(context,"backHome"),
              borderColor: MyColors.black,
              onTap: (){
                HomeMainData.pagingController.refresh();
                context.read<LocationCubit>().onLocationUpdated(LocationModel("0","0",""));
                AutoRouter.of(context).pop();
              }
          ),
        ],
      ),
    );
  }
}
