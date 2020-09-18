import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sampledeployapp/model/otpresponse.dart';
import 'package:sampledeployapp/widget/otp_receiver.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:http/http.dart' as http;

class LoginOTP extends StatefulWidget {
  LoginOTP({Key key}) : super(key: key);
  @override
  _LoginOTPState createState() => _LoginOTPState();
}

class _LoginOTPState extends State<LoginOTP> {
  final TextEditingController _testcontroller = TextEditingController();
  String mobile = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Enter Mobile number below"),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 10,
            ),
            child: TextField(
              onChanged: (value) {
                print(value);
                setState(() {
                  mobile = value;
                });
              },
              controller: _testcontroller,
              decoration: InputDecoration(
                hintText: '07XXXXXX',
              ),
              keyboardType: TextInputType.numberWithOptions(),
            ),
          ),
          MaterialButton(
            color: Colors.blue,
            child: Text(
              "Click me",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              //send post request here
              final appsignature = await SmsAutoFill().getAppSignature;
              getOTP(_testcontroller.text, appsignature);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => OtpReceiver()),
              );
            },
          ),
          Text(mobile)
        ],
      ),
    );
  }
}

Future getOTP(mobile, appsign) async {
  OtpResponse data;
  final response = await http.post(
    ("http://192.168.0.27:3000/" + "otp"),
    headers: {
      "Accept": "application/json",
      "content-type": "application/json",
    },
    body: jsonEncode(
      {
        'phonenumber': mobile,
        'appsignature': appsign,
      },
    ),
  );
  var myjson = json.decode(response.body);
  data = OtpResponse.fromJson(myjson);
  print(data.messageCode);
}
