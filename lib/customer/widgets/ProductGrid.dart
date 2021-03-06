import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:base_flutter/customer/models/AdsModel.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/widgets/CachedImage.dart';
import 'package:base_flutter/general/widgets/MyText.dart';


class ProductGrid extends StatelessWidget {
  final int index;
  final AdsModel model;
  const ProductGrid({Key key,@required this.index,@required this.model}) : super(key: key);

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width-50,
              height: 120,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return CachedImage(
                    url: model.allImg[index],
                    width: MediaQuery.of(context).size.width-50,
                    height: 120,
                    colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                    child: Icon(model.checkWishList? Icons.favorite :Icons.favorite_border,size: 25,color: MyColors.white,),
                    alignment: Alignment.topLeft,
                    borderRadius: BorderRadius.circular(5),
                  );
                },
                autoplay: false,
                itemCount: model.allImg.length,
                scrollDirection: Axis.horizontal,
                pagination: SwiperPagination(alignment: Alignment.bottomCenter),
                control: SwiperControl(),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width-25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MyText(title: model.title,size: 10,color: MyColors.greenColor,),
                      Spacer(),
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
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.person_outline,size: 20,color: MyColors.grey,),
                      MyText(title: model.userName,size: 8,color: MyColors.blackOpacity,),
                      Spacer(),
                      Icon(Icons.watch_later_outlined,size: 20,color: MyColors.grey,),
                      MyText(title: model.date,size: 8,color: MyColors.blackOpacity,),
                      Spacer(),
                      Icon(Icons.location_pin,size: 20,color: MyColors.grey,),
                      MyText(title: model.location,size: 8,color: MyColors.blackOpacity,),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
