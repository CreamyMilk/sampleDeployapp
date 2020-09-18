import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sampledeployapp/model/otpresponse.dart';

class OtpProvider extends ChangeNotifier {
  OtpResponse data;

  Future getOTP(context) async {
    final response = await http.post(
      ("https://192.168.0.27:3000/" + "otp"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode(
        {
          'phonenumber': '2540000',
          'appsignature': 'bEcXXteUfQi',
        },
      ),
    );
    var myjson = json.decode(response.body);
    this.data = OtpResponse.fromJson(myjson);
    notifyListeners();
    return data;
  }
}
