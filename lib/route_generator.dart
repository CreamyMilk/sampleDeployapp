import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampledeployapp/views/home_cards_layouts.dart';

import 'package:sampledeployapp/views/messageHandler.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    //final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MessageHandler());
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
