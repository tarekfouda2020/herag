import 'package:base_flutter/general/utilities/localization/LocalizationMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/general/widgets/MyText.dart';


class Politics extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PoliticsState();
  }

}

class _PoliticsState extends State<Politics>{

  GlobalKey<ScaffoldState> _scafold=new GlobalKey();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scafold,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            //background image
            Positioned(
              top: 0,
              left: 0,
              child: Image(image: AssetImage("images/shapeHome.png"),width: 200,height: 200,fit: BoxFit.fill,),
            ),

            AppBar(
              title: MyText(title: tr(context,"socialResponsibility"), //"المسؤلية الإجتماعية",
                size: 12,color: Colors.black54,),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.black54,),
                onPressed: ()=> Navigator.of(context).pop(),
              ),
              titleSpacing: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              elevation: 0,
              actions: <Widget>[
              ],
            ),
            // cart details
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.only(top: 120),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width-40,
                    child: MyText(
                      //title: "هذ النص يمكن استبدالة بنص اخر هذ النص يمكن استبدالة بنص اخر هذ النص يمكن استبدالة بنص اخر هذ النص يمكن استبدالة بنص اخر هذ النص يمكن استبدالة بنص اخر ",
                      title: tr(context,"sampleText"),
                      size: 12,
                      color: Colors.black54,
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}