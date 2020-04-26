import 'dart:async';
import 'dart:math';

import 'package:covidnotifassistant/useraddress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ScheduleGroceriesPage.dart';
import 'ConfigureSettingsPage.dart';
import 'covidessentials.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => MainPageState();
}


class MainPageState extends State<MainPage>{

  LocationData _currentLocation;
  Location _location;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  bool isAtHome = true;

  void initState() {
    super.initState();

    _location = new Location();

    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: _onSelectNotification);

    _location.onLocationChanged().listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      setState(() {
        _currentLocation = cLoc;
        if(_currentLocation!=null){
          getDistance(_currentLocation).then((dist){
            print("This is my distance: " + dist.toString());
            if(dist > 30 && isAtHome){
              _NotificationWithoutSoundWearMask();
              isAtHome = false;
            }
            if(dist < 30 && !isAtHome){
              _NotificationWithoutSoundWashHands();
              isAtHome = true;
            }
          });
        }
      });
    });
  }

  Future<double> getDistance(LocationData l) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myLatLong = prefs.getString("latlon");
    var latlon = myLatLong.split(" ");
    print("finding distance");

    var p = 0.017453292519943295;
    var c = cos;
    var lat2 = l.latitude;
    var lat1 = double.parse(latlon[0]);

    var lon2 = l.longitude;
    var lon1 = double.parse(latlon[1]);

    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742000 * asin(sqrt(a));
  }

  Future _onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: const Text("Thanks for staying safe!"),
//        content: new Text("Payload: $payload"),
      ),
    );
  }

  Future _NotificationWithoutSoundWearMask() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        playSound: false, importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      'Reminder',
      'Wear a mask before leaving the house!',
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }

  Future _NotificationWithoutSoundWashHands() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        playSound: false, importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      'Reminder',
      'Wash hands when entering the home!',
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }

  @override
  Widget build(BuildContext context) {
    Route route1 = MaterialPageRoute(builder: (context) => ScheduleGroceriesPage());
    Route route2 = MaterialPageRoute(builder: (context) => UserAddress());
    Route route3 = MaterialPageRoute(builder: (context) => FindPPE());
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