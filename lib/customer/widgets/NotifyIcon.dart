import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/general/blocs/notify_count_cubit/notify_count_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotifyIcon extends StatefulWidget {
  final Color color;

  const NotifyIcon({@required this.color});
  @override
  _NotifyIconState createState() => _NotifyIconState();
}

class _NotifyIconState extends State<NotifyIcon> {
  @override
  Widget build(BuildContext context) {
    var provider=context.watch<NotifyCountCubit>();
    return Container(
      height: 36,
      width: 40,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle
              ),
                child: Text('${provider.state.count}',style: TextStyle(fontSize: 10,color: Colors.white)),
            ),
          ),
          Icon(Icons.notifications, color: widget.color,size: 25,),
        ],
      ),
    );
  }
}
