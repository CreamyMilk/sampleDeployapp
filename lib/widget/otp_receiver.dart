import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sampledeployapp/model/otpconfirmmodel.dart';
import 'package:sampledeployapp/views/trans_view.dart';
import 'package:sampledeployapp/views/users_data.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:http/http.dart' as http;

class OtpReceiver extends StatefulWidget {
  OtpReceiver({Key key}) : super(key: key);

  @override
  _OtpReceiverState createState() => _OtpReceiverState();
}

class _OtpReceiverState extends State<OtpReceiver> {
  @override
  void initState() {
    super.initState();
    _listenforOTP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Enter Recieved pin here"),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 10,
            ),
            child: PinFieldAutoFill(
              autofocus: false,
              codeLength: 4,
              onCodeChanged: (val) {
                print(val);
                if (val.length == 4) {
                  confirmOTP("254599", val, context);
                  Navigator.of(context).pop();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void _listenforOTP() async {
    await SmsAutoFill().listenForCode;
  }
}

Future confirmOTP(mobile, code, context) async {
  OtpVerify data;
  final response = await http.post(
    ("http://192.168.0.27:3000/" + "verify"),
    headers: {
      "Accept": "application/json",
      "content-type": "application/json",
    },
    body: jsonEncode(
      {
        'phonenumber': mobile,
        'code': code,
      },
    ),
  );
  var myjson = json.decode(response.body);
  data = OtpVerify.fromJson(myjson);
  print(data.message);
  if (data.message == 0) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (c) => TransactionsView()),
    );
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (c) => UserTest(appTitle: "ok")),
    );
  }

  //Navigator.of(context).pop();
}
