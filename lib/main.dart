import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' show cos, sqrt, asin;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  LocationData _currentLocation;
  Location _location;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  double _distanceBetween;
  bool isAtHome = true;
  static final CameraPosition _shreyasHome = CameraPosition(
    target: LatLng(37.2718878,-122.0225271),
    zoom: 14.4746,
  );
  static final CameraPosition _shreyasNeighborHome = CameraPosition(
    target: LatLng(37.2719611,-122.0238443),
    zoom: 14.4746,
  );

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
          double dist = getDistance(_currentLocation);
          print("This is my distance: " + dist.toString());
          if(dist > 200 && isAtHome){
            _NotificationWithoutSoundWearMask();
            isAtHome = false;
          }
          if(dist < 200 && !isAtHome){
            _NotificationWithoutSoundWashHands();
            isAtHome = true;
          }
        }
      });
    });
  }

  double getDistance(LocationData l) {
    print("finding distance");

    var p = 0.017453292519943295;
    var c = cos;
    var lat2 = l.latitude;
    var lat1 = _shreyasHome.target.latitude;

    var lon2 = l.longitude;
    var lon1 = _shreyasHome.target.longitude;

    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742000 * asin(sqrt(a));
  }

  Future _onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: const Text("Here is your payload"),
        content: new Text("Payload: $payload"),
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
    return new Scaffold(
      body: Column(
        children: <Widget>[
//          Container(
//            height: 100,
//            child: InkWell(
//              onTap: _showNotificationWithoutSound,
//            ),
//          ),
          Container(
            height: 500,
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _shreyasHome,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),

          Text("Distance From home: " + ((_currentLocation!=null)?(getDistance(_currentLocation)).toString():"null")),

          Text("Home lat: " + _shreyasHome.target.latitude.toString() + "      Home Lon: " + _shreyasHome.target.longitude.toString()),

          (_currentLocation == null)
              ? Text("nothing yet")
              : Text("Current Lat: " +
              _currentLocation.latitude.toString() +
              "      Current Lon: " +
              _currentLocation.longitude.toString())
        ],
      ),

//      floatingActionButton: FloatingActionButton.extended(
//        onPressed: _goToTheLake,
//        label: Text('To the lake!'),
//        icon: Icon(Icons.directions_boat),
//      ),
    );
  }

//  static final CameraPosition _kLake = CameraPosition(
//      bearing: 192.8334901395799,
//      target: LatLng(37.43296265331129, -122.08832357078792),
//      tilt: 59.440717697143555,
//      zoom: 19.151926040649414);

//  Future<void> _goToTheLake() async {
//    final GoogleMapController controller = await _controller.future;
//    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//  }
}