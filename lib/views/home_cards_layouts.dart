import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sampledeployapp/views/issues_card.dart';
//import 'package:sampledeployapp/views/payments_selections.dart';
import 'package:sampledeployapp/views/rent_card.dart';
import 'package:sampledeployapp/views/services_card.dart';
//import 'package:sampledeployapp/widget/options_carosel.dart';

class HomeViewCardLayout extends StatefulWidget {
  HomeViewCardLayout({Key key}) : super(key: key);

  @override
  _HomeViewCardLayoutState createState() => _HomeViewCardLayoutState();
}

class _HomeViewCardLayoutState extends State<HomeViewCardLayout> {
  String _username = "Jotham";

  List<String> transactions = [
    "Transactions",
    "Joe",
    "Wick",
    "Mal",
    "grown",
    "1",
    "ewe",
    "wewe",
    "kaku"
  ];
  List<String> complains = ["Expenses", "Water", "Painting", "Gas"];
  Widget _myAnimatedWidget;
  ScrollController _cardsscrollcontroller;
  bool fadeswitch;
  _onUpdateScroll(ScrollMetrics metrics) {
    //print((metrics.pixels / 340.00).round());

    //setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fadeswitch = true;
    _cardsscrollcontroller = ScrollController();
    _myAnimatedWidget = CardListings(
      myItems: transactions,
      key: ValueKey(1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(
          Icons.atm,
          color: Colors.white,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              print(_cardsscrollcontroller.offset);
              fadeswitch = !fadeswitch;
              print(fadeswitch);
              _myAnimatedWidget = fadeswitch == true
                  ? CardListings(
                      myItems: complains,
                      key: ValueKey(2),
                    )
                  : CardListings(myItems: transactions, key: ValueKey(1));
            });
          }),
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
              //Slider area
              margin: EdgeInsets.all(16.0),
              //color: Colors.red[50],
              height: 300, //Cards Height
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollStartNotification) {
                    //print(scrollNotification.metrics);
                  } else if (scrollNotification is ScrollUpdateNotification) {
                    _onUpdateScroll(scrollNotification.metrics);
                  } else if (scrollNotification is ScrollEndNotification) {
                    //print(scrollNotification.metrics);
                  }
                  return;
                },
                child: ListView(
                  controller: _cardsscrollcontroller,
                  padding: EdgeInsets.all(4.0),
                  scrollDirection: Axis.horizontal,
                  children: [
                    PageCard(
                      childwidget: RentPaymentCard(),
                    ),
                    SizedBox(width: 10),
                    PageCard(
                      childwidget: IssuesCard(),
                    ),
                    SizedBox(width: 10),
                    PageCard(
                      childwidget: ServiceCard(),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            Container(
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _myAnimatedWidget))
          ],
        ),
      ),
    );
  }
}

class CardListings extends StatefulWidget {
  const CardListings({
    Key key,
    @required this.myItems,
  }) : super(key: key);

  final List<String> myItems;

  @override
  _CardListingsState createState() => _CardListingsState();
}

class _CardListingsState extends State<CardListings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white38,
      height: 400,
      child: ReorderableListView(
        header: Row(
          children: [
            SizedBox(
              height: 29,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.myItems[0],
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 5.0),
              ),
            ),
          ],
        ),
        onReorder: (oldIndex, newIndex) {
          print(oldIndex);
          print(newIndex);
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final item = widget.myItems.removeAt(oldIndex);
            widget.myItems.insert(newIndex, item);
          });
        },
        children: [
          for (final item in widget.myItems.sublist(1))
            ListTile(
              key: ValueKey(item),
              title: Text(item),
              subtitle: Text("${Timeline.now}"),
              leading: Icon(Icons.ac_unit),
              trailing: Text("Ksh.${Random().nextInt(10000).toString()}",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              focusColor: Colors.red,
              onTap: () {},
            ),
        ],
      ),
    );
  }
}

class PageCard extends StatelessWidget {
  final Widget childwidget;

  const PageCard({this.childwidget});

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
        child: this.childwidget);
  }
}
