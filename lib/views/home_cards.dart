import 'package:flutter/material.dart';
import 'package:sampledeployapp/views/payments_selections.dart';
//import 'package:sampledeployapp/widget/options_carosel.dart';

class HomeViewCardLayout extends StatefulWidget {
  HomeViewCardLayout({Key key}) : super(key: key);

  @override
  _HomeViewCardLayoutState createState() => _HomeViewCardLayoutState();
}

class _HomeViewCardLayoutState extends State<HomeViewCardLayout> {
  String _username = "Jotham";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 60.0),
          children: [
            Center(
              child: Text(
                "Hello, $_username",
                style: TextStyle(
                  letterSpacing: 2.0,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            Text("Welcome to ICRIB"),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Sample round icon
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Icon(Icons.accessibility_new,
                          size: 25.0, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                Pays(),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.all(16.0),
              color: Colors.red,
              height: 500,
              child: ListView(
                padding: EdgeInsets.all(4.0),
                scrollDirection: Axis.horizontal,
                children: [PageCard(), Text("ok"), PageCard()],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PageCard extends StatefulWidget {
  PageCard({Key key}) : super(key: key);

  @override
  _PageCardState createState() => _PageCardState();
}

class _PageCardState extends State<PageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Container(
            height: 120,
            width: 120,
            color: Colors.green,
            child: ListView(
              children: [
                Text("Pay Me now"),
                MaterialButton(
                    color: Colors.pink,
                    child: Text("Ok"),
                    onPressed: () {
                      print("Pay");
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PlantCard extends StatelessWidget {
  const PlantCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
