import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'ScheduleGroceriesPage.dart';
import 'ConfigureLocationPage.dart';
import 'ConfigureSettingsPage.dart';
import 'FindPPEPage.dart';

class MainPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Route route1 = MaterialPageRoute(builder: (context) => ScheduleGroceriesPage());
    Route route2 = MaterialPageRoute(builder: (context) => ConfigureLocationPage());
    Route route3 = MaterialPageRoute(builder: (context) => FindPPEPage());
    Route route4 = MaterialPageRoute(builder: (context) => ConfigureSettingsPage());
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Assistant', textAlign: TextAlign.center),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new ButtonTheme(
              minWidth: 200.0,
              height: 100.0,
              child: RaisedButton.icon(
                onPressed: () => Navigator.push(context, route1),
                color: Colors.lightBlue,
                icon: Icon(
                  Icons.local_grocery_store,
                  color: Colors.white,
                  size: 30,
                ),
                label: Text('Grocery Deliveries', style: new TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
            new SizedBox(height: 30),
            new ButtonTheme(
              minWidth: 200.0,
              height: 100.0,
              child: RaisedButton.icon(
                onPressed: () => Navigator.push(context, route2),
                color: Colors.lightBlue,
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.white,
                  size: 30,
                ),
                label: Text('Configure Location', style: new TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
            new SizedBox(height: 30),
            new ButtonTheme(
              minWidth: 200.0,
              height: 100.0,
              child: RaisedButton.icon(
                onPressed: () => Navigator.push(context, route3),
                color: Colors.lightBlue,
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
                label: Text('How to get/make PPE', style: new TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
            new SizedBox(height: 30),
            new ButtonTheme(
              minWidth: 200.0,
              height: 100.0,
              child: RaisedButton.icon(
                onPressed: () => Navigator.push(context, route4),
                color: Colors.lightBlue,
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 30,
                ),
                label: Text('Configure Settings', style: new TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}