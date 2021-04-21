import 'package:base_flutter/general/utilities/localization/LocalizationMethods.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/general/widgets/MyText.dart';
import 'package:photo_view/photo_view.dart';

// ignore: must_be_immutable
class ImageView extends StatefulWidget {
  String image;

  ImageView(this.image);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImageView();
  }
}

class _ImageView extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: MyText(
          title: "${tr(context, "image")}",
          color: Color(0xff5368a7),
          size: 16,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Color(0xff5368a7),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Color(0xfff7f7f7),
        alignment: Alignment.center,
        child: (widget.image != null)
            ? PhotoView(
                backgroundDecoration: BoxDecoration(
                  color: Color(0xfff7f7f7),
                ),
                imageProvider: NetworkImage(widget.image),
              )
            : Container(),
      ),
    );
  }
}
