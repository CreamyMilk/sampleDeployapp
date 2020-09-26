import 'package:flutter/material.dart';
import 'package:sampledeployapp/archive/users_data.dart';
import 'package:sampledeployapp/views/maps_view.dart';

class ServiceCard extends StatefulWidget {
  ServiceCard({Key key}) : super(key: key);

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  String _houseNumber = "A2";
  int _compains = 1;
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
              Container(child: Text("Services")),
              PopupMenuButton(
                  onSelected: (value) {
                    choiceAction(value, context);
                  },
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
            "Service Requests",
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
                      Text("Rate Service",
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  onPressed: () {
                    navigateToMap(context);
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
                      Text("Go to Map ", style: TextStyle(color: Colors.white)),
                      Icon(
                        Icons.zoom_out_map,
                        color: Colors.white,
                      )
                    ],
                  ),
                  onPressed: () {
                    navigateToMap(context);
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

void choiceAction(String choice, BuildContext context) {
  print(choice);
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => UserTest(appTitle: choice)),
  );
}

void navigateToMap(BuildContext context) {
  print("Going to map");
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => MapSample()),
  );
}
