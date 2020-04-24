import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class ScheduleGroceriesPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery Homepage', textAlign: TextAlign.center),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new SizedBox(height: 100),
            new ButtonTheme(
                minWidth: 200.0,
                height: 100.0,
                child: RaisedButton(
                  onPressed: () => launch('https://grocery.walmart.com/'),
                  color: Colors.lightBlue,
                  child: Text('Walmart Grocery (Economical)', style: new TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                )
            ),
            new SizedBox(height: 60),
            new ButtonTheme(
              minWidth: 200.0,
              height: 100.0,
              child: RaisedButton(
                onPressed: () => launch('https://www.instacart.com/'),
                color: Colors.lightBlue,
                child: Text('Instacart (Fast)', style: new TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
            new SizedBox(height: 60),
            new ButtonTheme(
              minWidth: 200.0,
              height: 100.0,
              child: RaisedButton(
                onPressed: () => launch('https://www.shipt.com/'),
                color: Colors.lightBlue,
                child: Text('Shipt (Convenient)', style: new TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}