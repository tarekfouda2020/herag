import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:base_flutter/general/widgets/AnimationContainer.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/widgets/DefaultButton.dart';
import 'package:base_flutter/general/widgets/MyText.dart';

class FollowedCars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: 4,
              itemBuilder: (context,index){
                return _buildCarItem(index,context);
              },
            )
        ),
        DefaultButton(title: "متابعة السيارات الجديدة", onTap: ()=>AutoRouter.of(context).pushPath(AddCarFollowerRoute.name))
      ],
    );
  }

  Widget _buildCarItem(int index,BuildContext context){
    return AnimationContainer(
      scale: true,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: InkWell(
            onTap: ()=>AutoRouter.of(context).pushPath(AddCarFollowerRoute.name),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: MyColors.greyWhite,
                        blurRadius: 1.2,
                        spreadRadius: 1.2
                    )
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(title: "كورلا",size: 11,color: MyColors.blackOpacity,),
                  MyText(title: "2020",size: 11,color: MyColors.blackOpacity,),
                  MyText(title: "الرياض",size: 11,color: MyColors.blackOpacity,),
                ],
              ),
            ),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Remove',
              color: Colors.red,
              icon: Icons.delete,
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }

}
