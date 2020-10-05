import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:sampledeployapp/model/otpresponse.dart';
//import 'package:sampledeployapp/widget/otp_receiver.dart';
//import 'package:sms_autofill/sms_autofill.dart';
import 'package:http/http.dart' as http;

class LoginOTP extends StatefulWidget {
  LoginOTP({Key key}) : super(key: key);
  @override
  _LoginOTPState createState() => _LoginOTPState();
}

class _LoginOTPState extends State<LoginOTP> {
  //final TextEditingController _testcontroller = TextEditingController();
  String mobile = "";
  bool term = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {}),
          title: Center(
            child: Row(children: [
              Spacer(),
              Text("ICRIB\nAgency",
                  style: TextStyle(fontWeight: FontWeight.w500)),
              Icon(
                Icons.tag_faces,
                color: Colors.white,
                size: 40,
              ),
              Spacer()
            ]),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: () {})
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 210),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Welcome To \nIcrib Residence",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
                Spacer(flex: 1),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                    onPressed: () {},
                    color: Colors.green,
                    child: Row(
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        ),
                        Icon(
                          Icons.lock,
                          size: 10,
                          color: Colors.white,
                        )
                      ],
                    ))
              ],
            ),
            Spacer(flex: 2),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                        height: 200,
                        color: Colors.white,
                        child: Text("See House Listings")),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: 200,
                          color: Colors.black,
                          child: LayoutBuilder(builder: (context, constraints) {
                            return Container(
                              height: 100,
                              width: constraints.maxWidth,
                              color: Colors.grey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.help_outline,
                                    size: constraints.maxWidth / 2.5,
                                    color: Colors.white,
                                  ),
                                  Text("Help")
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: 200,
                          color: Colors.black,
                          child: LayoutBuilder(builder: (context, constraints) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 3.0, color: Colors.transparent),
                                  ),
                                ),
                                height: 100,
                                width: constraints.maxWidth,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.help_outline,
                                      size: constraints.maxWidth / 2.5,
                                      color: Colors.white,
                                    ),
                                    Text("Help")
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Checkbox(
            //       onChanged: (bool value) {
            //         setState(() {
            //           term = !term;
            //           value = !value;
            //         });
            //       },
            //       value: term,
            //     ),
            //     Text("I accept the Terms & Conditions"),
            //   ],
            // ),
            // SizedBox(
            //   height: 50,
            // ),
            //Text("Enter Mobile number below"),
            // Container(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 50,
            //     vertical: 10,
            //   ),
            //   child: TextField(
            //     onChanged: (value) {
            //       print(value);
            //       setState(() {
            //         mobile = value;
            //       });
            //     },
            //     controller: _testcontroller,
            //     decoration: InputDecoration(
            //       suffixIcon: IconButton(
            //         icon: Icon(Icons.perm_contact_calendar),
            //         onPressed: () async {
            //           final PhoneContact contact =
            //               await FlutterContactPicker.pickPhoneContact();
            //           print(contact);
            //           setState(() {
            //             _testcontroller.text = contact.phoneNumber.number;
            //             mobile = contact.phoneNumber.number;
            //           });
            //         },
            //       ),
            //       hintText: 'PhoneNumber',
            //       errorText: validatePassword(_testcontroller.text),
            //       prefixText: "",
            //     ),
            //     keyboardType: TextInputType.numberWithOptions(),
            //   ),
            // ),
            // MaterialButton(
            //   color: term ? Colors.blue : Colors.grey,
            //   child: Text(
            //     "Click me",
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   onPressed: () async {
            //     //send post request here
            //     if (term) {
            //       final appsignature = await SmsAutoFill().getAppSignature;
            //       getOTP(_testcontroller.text, appsignature);
            //       Navigator.push(context,
            //           CupertinoPageRoute(builder: (c) => OtpReceiver()));
            //     } else {
            //       print("snack");
            //     }
            //   },
            // ),
          ],
        ));
  }
}

Future getOTP(mobile, appsign) async {
  OtpResponse data;
  final response = await http.post(
    ("http://googlesecureotp.herokuapp.com/" + "otp"),
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

String validatePassword(String value) {
  if (!(value.length > 9) && value.isNotEmpty) {
    return "Mobile number should be in the format 254xxx";
  }
  return null;
}

void showSnack(context) {}
