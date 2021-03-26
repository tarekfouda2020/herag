import 'package:flutter/material.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomPullRefresh extends StatefulWidget {

  final Widget child;
  final RefreshController controller;
  final Function onRefresh;

  const CustomPullRefresh({this.controller, this.onRefresh, this.child});

  @override
  _CustomPullRefreshState createState() => _CustomPullRefreshState();
}

class _CustomPullRefreshState extends State<CustomPullRefresh> {
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: WaterDropHeader(waterDropColor: MyColors.primary,),
      controller: widget.controller,
      onRefresh: widget.onRefresh,
      child: widget.child,
      physics: BouncingScrollPhysics(),
      footer: ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        completeDuration: Duration(milliseconds: 500),
        height: 100,
      ),
    );
  }
}
