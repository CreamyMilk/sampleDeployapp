import 'package:flutter/material.dart';
//import 'package:sampledeployapp/views/payments_selections.dart';
import 'package:sampledeployapp/views/rent_card.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                child: Text(
                  "Hello, $_username",
                  style: TextStyle(
                    letterSpacing: 2.0,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.all(16.0),
              //color: Colors.red[50],
              height: 300, //Cards Height
              child: ListView(
                padding: EdgeInsets.all(4.0),
                scrollDirection: Axis.horizontal,
                children: [PageCard(), SizedBox(width: 10), PageCard()],
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
        height: 1,
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: RentPaymentCard());
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
