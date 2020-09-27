import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:sampledeployapp/archive/users_data.dart';
import 'package:sampledeployapp/widget/payments_selections.dart';

class RentPaymentCard extends StatefulWidget {
  RentPaymentCard({Key key}) : super(key: key);

  @override
  _RentPaymentCardState createState() => _RentPaymentCardState();
}

class _RentPaymentCardState extends State<RentPaymentCard> {
  String _month = "January";
  int _rentDue = 20000;
  bool _testvar = true;
  List<String> option = ["All Transaction", "Recipts"];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Month  :",
                style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ),
              Container(child: Text("$_month")),
              PopupMenuButton(
                  onSelected: choiceAction,
                  icon: Icon(Icons.more_horiz),
                  itemBuilder: (BuildContext context) {
                    return option.map((String choice) {
                      return PopupMenuItem(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  }),
            ],
          ),
          Text(
            "Ksh.${_rentDue.toString()}",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 40.0,
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment will be done using \nMpesa express to \nMobile:0797678252",
                style: TextStyle(color: Colors.grey, fontSize: 10.0),
                maxLines: 3,
              ),
              AnimatedContainer(
                duration: Duration(seconds: 100),
                color: Colors.white,
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(5.0),
                child: MaterialButton(
                  color: _testvar ? Colors.black : Colors.grey,
                  child: Row(
                    children: [
                      Text("Pay now", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  onPressed: () {
                    _settingModalBottomSheet(context);
                    // showDialog(
                    //   //Text(message['notification']['title']
                    //   context: context,
                    //   builder: (context) => AlertDialog(
                    //       title: Text("Payment intent sent "),
                    //       content: Text("\n to 0797678252")),
                    // );
                    // setState(() {
                    //   _testvar = !_testvar;
                    // });                alignment: Alignment.bottomCenter,
                    print("STK push sent");
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

void _settingModalBottomSheet(context) {
  final TextEditingController _amountcontroller = TextEditingController();
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_downward),
                      Text(
                        "Rent Payment",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox()
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Amount in Ksh",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                      controller: _amountcontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: "",
                        hintText: "Enter Amount",
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select payment method",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PaymentTile(),
                      SizedBox(
                        width: 10,
                      ),
                      PaymentTile(),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Running low on Cash?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SelectContactField(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width * .90,
                        onPressed: () {
                          print("sdsdfdsf");
                          Navigator.of(context).pop();
                        },
                        color: Colors.black,
                        child: Text(
                          "Pay ${_amountcontroller.text}",
                          style: TextStyle(color: Colors.white),
                        ),
                        autofocus: true,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

void choiceAction(String choice) {
  print(choice);
  Navigator.push(
    null,
    MaterialPageRoute(builder: (_) => UserTest(appTitle: "ok")),
  );
}

class SelectContactField extends StatefulWidget {
  @override
  _SelectContactFieldState createState() => _SelectContactFieldState();
}

class _SelectContactFieldState extends State<SelectContactField> {
  final TextEditingController _testcontroller = TextEditingController();
  String mobile;
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      onChanged: (value) {
        print(value);
        setState(() {
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
            print(contact);
            setState(() {
              _testcontroller.text = contact.phoneNumber.number;
              mobile = contact.phoneNumber.number;
            });
          },
        ),
        border: OutlineInputBorder(gapPadding: 0.5),
        hintText: 'Ask somone else to pay',
        errorText: validatePassword(_testcontroller.text),
        prefixText: "",
      ),
      keyboardType: TextInputType.numberWithOptions(),
    );
  }
}

String validatePassword(String value) {
  if (!(value.length > 9) && value.isNotEmpty) {
    return "Mobile number should be in the format 254xxx";
  }
  return null;
}
