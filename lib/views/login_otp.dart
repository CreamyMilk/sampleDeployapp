import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sampledeployapp/model/otpresponse.dart';
import 'package:http/http.dart' as http;
import 'package:sms_autofill/sms_autofill.dart';

String otpNumber;

final _pageController = PageController(initialPage: 1);

class LoginOTP extends StatefulWidget {
  LoginOTP({Key key}) : super(key: key);
  @override
  _LoginOTPState createState() => _LoginOTPState();
}

class _LoginOTPState extends State<LoginOTP> {
  Widget _myAnimatedWidget;
  String mobile = "";
  bool term = false;
  @override
  void initState() {
    super.initState();
    _myAnimatedWidget = _Logincard();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: Visibility(
          visible: false,
          child: FloatingActionButton.extended(
              tooltip: "Recieve OTP FROM SERVER",
              backgroundColor: Colors.green,
              onPressed: () async {
                //send post request here
                final appsignature = await SmsAutoFill().getAppSignature;
                //todo add loading
                if (otpNumber.length > 9) {
                  await getOTP(otpNumber, appsignature);
                  Navigator.of(context).pushNamed('/otprec');
                }
              },
              label: Text("Get OTP"),
              icon: Icon(Icons.phone)),
        ),
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
        body: PageView(
          controller: _pageController,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 210),
                AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: _myAnimatedWidget,
                ),
                Spacer(flex: 2),
                _ThreeBButtons(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 210),
                PhoneNumberForm(),
                Spacer(flex: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ThreeBButtons extends StatelessWidget {
  const _ThreeBButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Position>(builder: (context, position, child) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Container(
                  height: 200,
                  color: Colors.orangeAccent,
                  child: Text("See\n House Listings",
                      style: TextStyle(fontSize: 30))),
            ),
            SizedBox(width: 5),
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (position != null) {
                        Navigator.of(context)
                            .pushNamed('/map', arguments: position);
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Turn on location service")));
                      }
                    },
                    child: Container(
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
                                bottom:
                                    BorderSide(width: 3.0, color: Colors.white),
                              ),
                            ),
                            height: 100,
                            width: constraints.maxWidth,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.map,
                                  size: constraints.maxWidth / 2.5,
                                  color: Colors.white,
                                ),
                                Text("Service\nMap",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
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
                              bottom:
                                  BorderSide(width: 3.0, color: Colors.white),
                            ),
                          ),
                          height: 100,
                          width: constraints.maxWidth,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.help_outline,
                                size: constraints.maxWidth / 2.5,
                                color: Colors.white,
                              ),
                              Text("Help\nContacts",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ))
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
      );
    });
  }
}

class _Logincard extends StatelessWidget {
  const _Logincard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
          onPressed: () {
            Navigator.of(context).pushNamed('/otprec');
          },
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
          ),
        )
      ],
    );
  }
}

class PhoneNumberForm extends StatefulWidget {
  const PhoneNumberForm({Key key}) : super(key: key);

  @override
  _PhoneNumberFormState createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm> {
  final TextEditingController _testcontroller = TextEditingController();
  String mobile = "";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 10,
          ),
          child: TextField(
            cursorColor: Colors.white,
            onChanged: (value) {
              print(value);
              setState(() {
                otpNumber = value;
                mobile = value;
              });
            },
            controller: _testcontroller,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.perm_contact_calendar),
                onPressed: () async {
                  final PhoneContact contact =
                      await FlutterContactPicker.pickPhoneContact();
                  setState(() {
                    _testcontroller.text = contact.phoneNumber.number;
                    mobile = contact.phoneNumber.number;
                    otpNumber = mobile;
                  });
                },
              ),
              hintText: 'PhoneNumber',
              errorText: validatePassword(_testcontroller.text),
              prefixText: "",
            ),
            keyboardType: TextInputType.numberWithOptions(),
          ),
        ),
      ]),
    );
  }
}

Future getOTP(mobile, appsign) async {
  OtpResponse data;
  print('Phone $mobile');
  if (mobile != null) {
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
  } else {
    print('Please add number');
  }
}

String validatePassword(String value) {
  if (!(value.length > 9) && value.isNotEmpty) {
    return "Mobile number should be in the format 2547xx";
  }
  return null;
}

void showSnack(context) {}
