import 'package:flutter/widgets.dart';
import 'package:base_flutter/general/constants/GlobalNotification.dart';
import 'package:base_flutter/general/utilities/utils_functions/UtilsImports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/widgets/AnimationContainer.dart';
import 'package:base_flutter/res.dart';
import 'package:video_player/video_player.dart';


class AnimatedSplash extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=>_SplashState();
}

class _SplashState extends State<AnimatedSplash> {

  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  VideoPlayerController _controller;


  @override
  void initState() {
    _controller = VideoPlayerController.asset(Res.haraj)..initialize();
    _controller.play();
    Future.delayed(Duration(seconds: 2),(){
      Utils.manipulateSplashData(context);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      backgroundColor: MyColors.primary,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: VideoPlayer(_controller)
      )
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
