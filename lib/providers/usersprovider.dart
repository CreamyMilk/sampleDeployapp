import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sampledeployapp/model/transaction.dart';

class MyTransactionprovider extends ChangeNotifier {
  MyData data;

  Future getData(context) async {
    final response = await http
        .get(("https://googlesecurev2.herokuapp.com/" + "usersa"), headers: {
      "Accept": "application/json",
      "content-type": "application/json",
    });
    var myjson = json.decode(response.body);
    this.data = MyData.fromJson(myjson);
    notifyListeners();
    return data;
  }
}
