import 'dart:convert';
import 'dart:io';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

//Outside any class
Future<dynamic> myBackgroundHandler(Map<String, dynamic> message) {
  return _MessageHandlerState()._showNotification(message);
}

class _MessageHandlerState extends State<MessageHandler> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _fcm = FirebaseMessaging();
  Future selectLocalNotificationAction(String payload) async {
    //replace for legit handler
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    //Localnotification
    // var initializationSettingsAndroid =
    //     AndroidInitializationSettings('app_icon');
    // var initializationSettingsIOS = IOSInitializationSettings(
    //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings =
        InitializationSettings(initializationSettingsAndroid, null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectLocalNotificationAction);
    //Ios Setup
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(
        IosNotificationSettings(),
      );
    } else {
      //Android Setup
      _saveDeviceToken();
    }

    //Subscribe to topic frontEND
    _fcm.subscribeToTopic("tenant");
    //Unsubscribe to topic
    //_fcm.unsubscribeFromTopic("Teneant");

    _fcm.configure(
      onBackgroundMessage: myBackgroundHandler,
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
    return Container(
      color: Colors.teal,
    );
  }

  //LocalNotification
  Future _showNotification(Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel desc',
      importance: Importance.Max,
      priority: Priority.High,
    );

    var platformChannelSpecifics =
        new NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
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
      'https://jsonplaceholder.typicode.com/albums',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
  }
}
