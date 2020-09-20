import 'package:flutter/material.dart';

class OptionsCarosel extends StatelessWidget {
  const OptionsCarosel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView(
        children: [
          RedBox(),
          RedBox(),
        ],
      ),
    );
  }
}

class RedBox extends StatelessWidget {
  const RedBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.red,
      child: Text("Ok"),
    );
  }
}
