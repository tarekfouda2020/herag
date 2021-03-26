import 'package:flutter/material.dart';
import 'package:base_flutter/general/constants/Inputs/InkWellTextField.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/widgets/DefaultAppBar.dart';
import 'package:base_flutter/general/widgets/DefaultButton.dart';
import 'package:base_flutter/general/widgets/MyText.dart';

class AddCarFollower extends StatelessWidget {

  final TextEditingController _city=new TextEditingController();
  final TextEditingController _brand=new TextEditingController();
  final TextEditingController _model=new TextEditingController();
  final TextEditingController _year=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "متابعة سيارة جديدة",con: context,),
      backgroundColor: MyColors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        children: [
          _buildInputItem(controller: _city,title: "المدينة"),
          _buildInputItem(controller: _brand,title: "الماركة"),
          _buildInputItem(controller: _model,title: "الموديل"),
          _buildInputItem(controller: _year,title: "سنة الصنع"),
          DefaultButton(title: "استمرار", onTap: (){})
        ],
      ),
    );
  }


  Widget _buildInputItem({TextEditingController controller, String title}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: MyText(title: title,size: 10,color: MyColors.black,),
        ),
        SizedBox(height: 5,),
        InkWellTextField(
          controller: controller,
          label: "اختر $title",
          onTab: (){},
          dropDown: true,
          icon: Icon(Icons.keyboard_arrow_down_outlined,size: 25,color: MyColors.primary,),
        )
      ],
    );
  }

}
