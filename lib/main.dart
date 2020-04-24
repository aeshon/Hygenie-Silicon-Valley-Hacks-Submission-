import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

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
            new Text("Welcome to the COVID Assistant!", textAlign: TextAlign.center, style: new TextStyle(color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold),),
            new SizedBox(height: 20),
            new Text("Tap anywhere to continue", textAlign: TextAlign.center, style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),)
          ]
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Route route1 = MaterialPageRoute(builder: (context) => ScheduleGroceriesPage());
    Route route2 = MaterialPageRoute(builder: (context) => ConfigureLocationPage());
    Route route3 = MaterialPageRoute(builder: (context) => FindPPEPage());
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
                onPressed: () => Navigator.push(context, route1),
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
                onPressed: () => Navigator.push(context, route1),
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
                onPressed: () => Navigator.push(context, route1),
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
              child: RaisedButton.icon(
                onPressed: () => launch('https://grocery.walmart.com/'),
                color: Colors.lightBlue,
                label: Text('Walmart Grocery (Economical)', style: new TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              )
            ),
            new SizedBox(height: 60),
            new ButtonTheme(
              minWidth: 200.0,
              height: 100.0,
              child: RaisedButton.icon(
                onPressed: () => launch('https://www.instacart.com/'),
                color: Colors.lightBlue,
                label: Text('Instacart (Fast)', style: new TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
            new SizedBox(height: 60),
            new ButtonTheme(
              minWidth: 200.0,
              height: 100.0,
              child: RaisedButton.icon(
                onPressed: () => launch('https://www.shipt.com/'),
                color: Colors.lightBlue,
                label: Text('Shipt (Convenient)', style: new TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
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