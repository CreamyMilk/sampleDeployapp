import 'package:flutter/material.dart';
import 'package:sampledeployapp/archive/users_data.dart';

class ServiceCard extends StatefulWidget {
  ServiceCard({Key key}) : super(key: key);

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  String _houseNumber = "A2";
  int _compains = 4;
  bool _testvar = true;
  List<String> option = ["Maps", "History"];
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
                "HouseNo  :$_houseNumber",
                style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ),
              Container(child: Text("Issues")),
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
            "${_compains.toString()}",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 40.0,
            ),
          ),
          Text(
            "complains",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 20.0,
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 100),
                color: Colors.white,
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(5.0),
                child: MaterialButton(
                  color: _testvar ? Colors.white : Colors.grey,
                  child: Row(
                    children: [
                      Text("Past Complains",
                          style: TextStyle(color: Colors.black)),
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
              AnimatedContainer(
                duration: Duration(seconds: 100),
                color: Colors.white,
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(5.0),
                child: MaterialButton(
                  color: _testvar ? Colors.black : Colors.grey,
                  child: Row(
                    children: [
                      Text("Report !", style: TextStyle(color: Colors.white)),
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
