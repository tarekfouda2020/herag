import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/AdsModel.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/widgets/CachedImage.dart';
import 'package:base_flutter/general/widgets/MyText.dart';


class ProductRow extends StatelessWidget {
  final int index;
  final AdsModel model;
  ProductRow({@required this.index,@required this.model});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>AutoRouter.of(context).push(ProductDetailsRoute(model: model,info: model.info)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        decoration: BoxDecoration(
            color: index.isEven?Colors.white60 : MyColors.white,
            boxShadow: [
              BoxShadow(
                  color: MyColors.greyWhite,
                  spreadRadius: 1,
                  blurRadius: 1
              )
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width-150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(title: model.title,size: 10,color: MyColors.greenColor,),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Visibility(
                          child: Icon(Icons.thumb_up_off_alt,size: 20,color: MyColors.primary,),
                        visible: model.checkRate,
                      ),
                      SizedBox(width: 5,),
                      Visibility(
                        visible: model.countComment>0,
                        child: Row(
                          children: [
                            Icon(Icons.comment_outlined,size: 20,color: MyColors.grey,),
                            MyText(title: "${model.countComment}",size: 8,color: MyColors.blackOpacity,),
                          ],
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.watch_later_outlined,size: 17,color: MyColors.grey,),
                      SizedBox(width: 2,),
                      MyText(
                        title: model.date,
                        size: 7,
                        color: MyColors.blackOpacity,
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.person_outline,size: 20,color: MyColors.grey,),
                      MyText(title: model.userName,size: 8,color: MyColors.blackOpacity,),
                      Spacer(),
                      Icon(Icons.location_pin,size: 20,color: MyColors.grey,),
                      SizedBox(width: 2,),
                      MyText(
                        title: model.location,
                        size: 8,
                        color: MyColors.blackOpacity,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CachedImage(
              url: model.img,
              width: 120,
              height: 100,
              colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
              child: Icon(model.checkWishList? Icons.favorite :Icons.favorite_border,size: 25,color: MyColors.white,),
              alignment: Alignment.topLeft,
              borderRadius: BorderRadius.circular(5),
            )
          ],
        ),
      ),
    );
  }
}
