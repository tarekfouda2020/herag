import 'package:flutter/material.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/widgets/MyText.dart';

class TitleButton extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function onTap;
  final EdgeInsets padding;
  final Color iconColor;

  const TitleButton({@required this.iconData,@required this.title,@required this.onTap,this.padding,this.iconColor});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:padding?? EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Row(
          children: [
            Icon(iconData,size: 20,color: iconColor?? Colors.black45,),
            SizedBox(width: 10,),
            MyText(title: title,size: 10,color: MyColors.blackOpacity,)
          ],
        ),
      ),
    );
  }
}
