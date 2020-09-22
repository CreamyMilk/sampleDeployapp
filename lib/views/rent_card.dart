import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:sampledeployapp/views/users_data.dart';

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
                    showDialog(
                      //Text(message['notification']['title']
                      context: context,
                      builder: (context) => AlertDialog(
                          title: Text("Payment intent sent "),
                          content: Text("\n to 0797678252")),
                    );
                    setState(() {
                      _testvar = !_testvar;
                    });
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

void choiceAction(String choice) {
  print(choice);
  Navigator.push(
    null,
    MaterialPageRoute(builder: (_) => UserTest(appTitle: "ok")),
  );
}
