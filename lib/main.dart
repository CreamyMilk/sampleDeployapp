import 'package:flutter/material.dart';
import 'package:sampledeployapp/views/home_cards.dart';
//import 'package:sampledeployapp/views/home_cards.dart';
//import 'package:sampledeployapp/views/payments_selections.dart';
//import 'package:sampledeployapp/views/maps_view.dart';
//import 'package:sampledeployapp/widget/login_otp.dart';
//import 'package:sampledeployapp/views/users_data.dart';
import 'package:sampledeployapp/widget/messageHandler.dart';
import 'package:sampledeployapp/widget/tickmark.dart';
import 'package:sampledeployapp/widget/transactionmessage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String appTitle = 'Firebase messaging';
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF3EBACE),
          accentColor: Color(0xFFD8ECF1),
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        darkTheme: ThemeData(
          primaryColor: Color(0xFF3EBACE),
          accentColor: Color(0xFFD8ECF1),
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        home: HomeViewCardLayout(),
        //home: MapSample(),
        //home: LoginOTP(),
        //home: UserTest(appTitle: appTitle),
      );
}

class MainPage extends StatelessWidget {
  final String appTitle;

  const MainPage({this.appTitle});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [MessageHandler(), Tick(), TransCard()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.monetization_on),
        onPressed: () {},
      ));
}
