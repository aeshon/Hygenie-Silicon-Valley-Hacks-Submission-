import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:covidnotifassistant/MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatelessWidget{

  Route _route = MaterialPageRoute(builder: (context) => MainPage());

  @override
  Widget build(BuildContext context) {

    return new Material(
      color: Colors.lightBlue,
      child: new InkWell(
        onTap: () => Navigator.push(context, _route),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              Image.asset('assests/images/hygenie.jpg'),
              new Text("Welcome to the HyGenie COVID-19 Assistant!", textAlign: TextAlign.center, style: new TextStyle(color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold),),
              new SizedBox(height: 20),
              new Text("Tap anywhere to continue", textAlign: TextAlign.center, style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),)
            ]
        ),
      ),
    );
  }
}