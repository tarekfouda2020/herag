import 'package:flutter/material.dart';
import 'package:base_flutter/general/blocs/chat_count_cubit/chat_count_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatIcon extends StatefulWidget {
  final Color color;

  const ChatIcon({@required this.color});
  @override
  _ChatIconState createState() => _ChatIconState();
}

class _ChatIconState extends State<ChatIcon> {
  @override
  Widget build(BuildContext context) {
    var provider=context.watch<ChatCountCubit>();
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
          Icon(Icons.mail_outline, color: widget.color,size: 25,),
        ],
      ),
    );
  }
}
