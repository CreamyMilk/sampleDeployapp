import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sampledeployapp/archive/users_data.dart';
import 'package:sampledeployapp/services/geolocation_service.dart';
import 'package:sampledeployapp/views/home_cards_layouts.dart';
import 'package:sampledeployapp/views/login_otp.dart';

import 'package:sampledeployapp/views/messageHandler.dart';

final GeolocatorService geoService = GeolocatorService();

class RouteGenerator {
  static get geoService => null;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    //final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => StartUpScreenProvider());
      case '/randomUser':
        return MaterialPageRoute(
            builder: (_) => UserTest(
                  appTitle: 'ok',
                ));
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginOTP());
      case '/home':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondAnimation) {
            return ListenableProvider(
                create: (context) => animation,
                child: HomeViewCardLayout(
                  transitionAnime: animation,
                ));
          },
          transitionDuration: const Duration(seconds: 2),
        );

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class StartUpScreenProvider extends StatelessWidget {
  const StartUpScreenProvider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      FutureProvider<Position>(
          create: (context) => geoService.getInitialLocation()),
      // Provider<MpexaProvider>(
      //   create: (_) => MpexaProvider(),
      // ),
    ], child: MyMessageHandler());
  }
}
