import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: LandingPage(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  LocationData currentLocation;
  Location location;

  void initState() {
    super.initState();
    Fluttertoast.showToast(
        msg: "changed location",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    location = new Location();

    location.onLocationChanged().listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      setState(() {
        currentLocation = cLoc;
      });
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 550,
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          (currentLocation == null)
              ? Text("nothing yet")
              : Text("Current Lat: " +
              currentLocation.latitude.toString() +
              "      Current Lon: " +
              currentLocation.longitude.toString())
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

class LandingPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Route route = MaterialPageRoute(builder: (context) => MainPage());
    return new Material(
      color: Colors.lightBlue,
      child: new InkWell(
        onTap: () => Navigator.push(context, route),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Welcome to the COVID Assistant", style: new TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),),
            new Text("Tap anywhere to continue", style: new TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),)
          ]
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Route route1 = MaterialPageRoute(builder: (context) => ScheduleActivitiesPage());
    Route route2 = MaterialPageRoute(builder: (context) => ConfigureLocationPage());
    Route route3 = MaterialPageRoute(builder: (context) => FindPPEPage());
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Assistant'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            new RaisedButton.icon(
                onPressed: () => Navigator.push(context, route1),
                color: Colors.lightBlue,
                icon: Icon(
                  Icons.calendar_today
                ),
                label: Text('Schedule Activities', style: new TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))
            ),
            new RaisedButton.icon(
                onPressed: () => Navigator.push(context, route2),
                color: Colors.lightBlue,
                icon: Icon(
                  Icons.edit_location
                ),
                label: Text('Configure Location', style: new TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))),
            new RaisedButton.icon(
                onPressed: () => Navigator.push(context, route3),
                color: Colors.lightBlue,
                icon: Icon(
                  Icons.search
                ),
                label: Text('How to make your own PPE!', style: new TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
  }
}

class ScheduleActivitiesPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}

class ConfigureLocationPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}

class FindPPEPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}