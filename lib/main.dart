import 'package:flutter/material.dart';
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
        home: MessageHandler(),
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
