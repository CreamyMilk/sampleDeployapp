import 'dart:convert';
import 'dart:io';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sampledeployapp/views/home_cards_layouts.dart';
import 'package:sampledeployapp/views/login_otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

//Outside any class
Future<dynamic> myBackgroundHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
    print(data);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print(notification);
  }
  return _MessageHandlerState()._showNotification(message);
}

class _MessageHandlerState extends State<MessageHandler> {
  String userToken;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _fcm = FirebaseMessaging();
  Future selectLocalNotificationAction(String payload) async {
    //replace for legit handler
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  void initState() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    //Localnotification
    // var initializationSettingsAndroid =
    //     AndroidInitializationSettings('app_icon');
    // var initializationSettingsIOS = IOSInitializationSettings(
    //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings =
        InitializationSettings(initializationSettingsAndroid, null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectLocalNotificationAction);
    super.initState();

    //Ios Setup
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(
        IosNotificationSettings(),
      );
    } else {
      _saveDeviceToken();
    }

    //Subscribe to topic frontEND
    _fcm.subscribeToTopic("tenant");
    //Unsubscribe to topic
    //_fcm.unsubscribeFromTopic("Teneant");
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage :$message");
        //Disply Dialogue
        showDialog(
          //Text(message['notification']['title']
          context: context,
          builder: (context) => AlertDialog(
              title: AspectRatio(
                aspectRatio: 1.5,
                child: FlareActor(
                  'assets/tick.flr',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: 'go',
                ),
              ),
              content: Text("Your Transaction was Succesful")),
        );
      },
      onBackgroundMessage: myBackgroundHandler,
      onResume: (Map<String, dynamic> message) async {
        print("onMessage :$message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onMessage :$message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _getStartUpPage(context);
    return Container(
      color: Colors.yellow,
      child: null,
    );
  }

  //LocalNotification
  Future _showNotification(Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      '23232',
      'me',
      'New',
      importance: Importance.Max,
      priority: Priority.High,
    );

    var platformChannelSpecifics =
        new NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
      0,
      "Random Title", //message['notification']['title'],
      "Random Body", //message['notification']['body'],
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  //Get token, save it to the datbase for current user
  _saveDeviceToken() async {
    // Get the current user
    String uid = 'Jotham254';

    //Auth service  = await _auth.currentUser(); // Gives me logged in user details
    String fcmToken = await _fcm.getToken();

    //Send to backend
    if (fcmToken != null) {
      final data = {
        'uid': uid,
        'token': fcmToken,
        'platform': Platform.operatingSystem
      };
      //http.post
      _sendTokenHTTP(data);
    }
  }

  _sendTokenHTTP(final data) async {
    return http.post(
      "http://googlesecureotp.herokuapp.com/verify",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
  }
}

_getStartUpPage(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final userToken = prefs.getString('user_token') ?? "";
  print("UserToken ilikuwa $userToken");
  Future.delayed(Duration(seconds: 5), () {
    userToken == "0"
        ? Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondAnimation) {
              return HomeViewCardLayout(
                transitionAnime: animation,
              );
            },
            transitionDuration: const Duration(seconds: 5)))
        : Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => LoginOTP()),
          );
  });
}
