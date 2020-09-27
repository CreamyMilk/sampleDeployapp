import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sampledeployapp/providers/mpesaTransPorvider.dart';
import 'package:sampledeployapp/services/geolocation_service.dart';
//import 'package:sampledeployapp/views/login_otp.dart';
import 'package:sampledeployapp/widget/messageHandler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String appTitle = 'Firebase messaging';
  final GeolocatorService geoService = GeolocatorService();
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
          FutureProvider<Position>(
              create: (context) => geoService.getInitialLocation()),
          Provider<MpexaProvider>(
            create: (_) => MpexaProvider(),
          ),
        ], child: MessageHandler()
            //child: MessageHandler(),
            ),
      );
}
