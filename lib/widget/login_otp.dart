import 'package:flutter/material.dart';
import 'package:sampledeployapp/widget/otp_receiver.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginOTP extends StatefulWidget {
  LoginOTP({Key key}) : super(key: key);

  @override
  _LoginOTPState createState() => _LoginOTPState();
}

class _LoginOTPState extends State<LoginOTP> {
  TextEditingController _testcontroller;
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
              print(appsignature);
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => OtpReceiver()));
            },
          ),
        ],
      ),
    );
  }
}
