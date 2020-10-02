import 'package:flutter/material.dart';
import 'package:sampledeployapp/views/home_cards_layouts.dart';
import 'package:sampledeployapp/views/login_otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartUpView extends StatefulWidget {
  @override
  _StartUpViewState createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  String userToken;

  @override
  void initState() async {
    final prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('user_token') ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return userToken == "" ? LoginOTP() : HomeViewCardLayout();
  }
}
