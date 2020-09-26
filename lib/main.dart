import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:sampledeployapp/archive/login_otp.dart';
import 'package:sampledeployapp/providers/mpesaTransPorvider.dart';
import 'package:sampledeployapp/views/home_cards_layouts.dart';
//import 'package:sampledeployapp/views/rent_card.dart';
//import 'package:sampledeployapp/views/repflectly_home.dart';
//import 'package:sampledeployapp/views/maps_view.dart';
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
          primaryColor: Colors.blue,
          accentColor: Colors.blueAccent,
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        darkTheme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.blueAccent,
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        home: MultiProvider(providers: [
          Provider<MpexaProvider>(
            create: (_) => MpexaProvider(),
          ),
        ], child: HomeViewCardLayout()
            //child: MessageHandler(),
            ),
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
