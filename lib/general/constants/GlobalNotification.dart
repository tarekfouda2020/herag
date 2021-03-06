import 'dart:async';
import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:base_flutter/customer/models/AdsModel.dart';
import 'package:base_flutter/general/blocs/chat_count_cubit/chat_count_cubit.dart';
import 'package:base_flutter/general/blocs/notify_count_cubit/notify_count_cubit.dart';
import 'package:base_flutter/general/utilities/moor_db/db.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/utilities/utils_functions/UtilsImports.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalNotification {
  static StreamController<Map<String, dynamic>> _onMessageStreamController =
      StreamController.broadcast();

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  static BuildContext _context;
  static GlobalNotification instance = new GlobalNotification._();

  GlobalNotification._();

  GlobalNotification();

  setupNotification({BuildContext context})async {
    _context = context;
    _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings("@mipmap/launcher_icon");
    var ios = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android: android, iOS: ios);
    _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: flutterNotificationClick,
    );
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(provisional: true);
    print('User granted permission: ${settings.authorizationStatus}');
    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      messaging.getToken().then((token) {
        print(token);
      });
      messaging.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);
      // messaging.getInitialMessage().then((message) => _showLocalNotification(message));
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("_____________________Message data:${message.data}");
        print("_____________________notification:${message.notification.title}");
        _showLocalNotification(message);
        _onMessageStreamController.add(message.data);
        if (int.parse(message.data["type"]) == -1) {
          Utils.clearSavedData();
          context.router.push(LoginRoute());
        }
      });
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        flutterNotificationClick(json.encode(message.data));
      });
    }

  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message..messageId}");
    flutterNotificationClick(json.encode(message.data));
  }

  StreamController<Map<String, dynamic>> get notificationSubject {
    return _onMessageStreamController;
  }

  _showLocalNotification(RemoteMessage message) async {
    if (message == null) return;
    int _type = int.parse(message.data["type"]??"0");
    if(_type==9){
      _context.read<ChatCountCubit>().onUpdateCount(_context.read<ChatCountCubit>().state.count+1);
    }else{
      _context.read<NotifyCountCubit>().onUpdateCount(_context.read<NotifyCountCubit>().state.count+1);
    }
    var android = AndroidNotificationDetails(
      "${DateTime.now()}",
      "${message.notification.title}",
      "${message.notification.body}",
      priority: Priority.high,
      importance: Importance.max,
      playSound: true,
      shortcutId: DateTime.now().toIso8601String(),
    );
    var ios = IOSNotificationDetails();
    var _platform = NotificationDetails(android: android, iOS: ios);
    _flutterLocalNotificationsPlugin.show(
        DateTime.now().microsecond, "${message.notification.title}", "${message.notification.body}", _platform,
        payload: json.encode(message.data));
  }

  static Future flutterNotificationClick(String payload) async {

    print("tttttttttt $payload");
    var _data = json.decode(payload);

    int _type = int.parse(_data["type"]??"4");


    if (_type >= 1 && _type <= 4) {
      var adInfo= json.decode(_data["ads_info"]);
      AdsModel model = new AdsModel.fromMap(adInfo);
      _context.router.push(ProductDetailsRoute(model: model));
    } else if(_type ==5||_type ==6||_type ==8) {
      _context.router.push(UserProductsRoute(userId: _data["user_id"],userName: _data["user_name"]));
    } else if(_type ==9) {
      _context.router.push(ChatRoute(userName: _data["userName"],receiverId: _data["receiverId"],senderId: _data["senderId"]));
    } else if(_type ==7) {
      int parentCount=(await _context.read<MyDatabase>().selectParentCatsAsync()).length;
      _context.router.push(HomeRoute(parentCount: parentCount,tab: 2));
    }
  }
}
