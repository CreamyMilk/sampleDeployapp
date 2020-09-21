import 'package:flutter/material.dart';

class RentCard extends StatefulWidget {
  RentCard({Key key}) : super(key: key);

  @override
  _RentCardState createState() => _RentCardState();
}

class _RentCardState extends State<RentCard> {
  String _month = "January";
  int _rentDue = 20000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Rent Due",
                  style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
                Text("$_month")
              ],
            ),
            Text(
              "Ksh.${_rentDue.toString()}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            MaterialButton(
              child: Text("Pay now"),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
