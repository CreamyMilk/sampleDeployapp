import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sampledeployapp/route_generator.dart';
import 'package:sampledeployapp/services/geolocation_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  final String appTitle = 'Firebase messaging';
  final GeolocatorService geoService = GeolocatorService();
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.lightBlue,
          accentColor: Colors.lightBlueAccent,
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        darkTheme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.black38,
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/',
      );
}
