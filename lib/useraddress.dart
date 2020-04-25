import 'package:covidnotifassistant/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAddress extends StatefulWidget {
  @override
  State<UserAddress> createState() => UserAddressState();
}

class UserAddressState extends State<UserAddress> {

  Location _location;
  LocationData _currLocation;

  Future _setHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(_currLocation.latitude.toString() + " " + _currLocation.longitude.toString());
    await prefs.setString('latlon', _currLocation.latitude.toString() + " " + _currLocation.longitude.toString());
  }

  void initState(){
    super.initState();
    _location = new Location();
    _location.onLocationChanged().listen((LocationData cLoc) {
      setState(() {
        _currLocation = cLoc;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Route route1 = MaterialPageRoute(builder: (context) => MainPage());

    return MaterialApp(
      title: 'SnackBar Demo',
      home: Scaffold(
        appBar: AppBar(
          title: new Center(
              child: new Text('Location', textAlign: TextAlign.center)),
        ),
        body: Builder(
          builder: (context) => Center(
            child: new Column(
              children: <Widget>[
                Spacer(
                  flex: 3,
                ),
                Text("Please click 'Configure' to set your home address",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
                Spacer(),
                RaisedButton(
                  onPressed: () {
                    //ENTER LOCATION CODE HERE
                    if(_currLocation==null){
                      final snackBar = SnackBar(
                        content: Text('Error! try again!'),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(
                        content: Text('Location has been configured'),
                      );
                      _setHome().then((onValue){
                        Scaffold.of(context).showSnackBar(snackBar);
                      });
                    }
                  },
                  child: Text('Configure'),
                ),
                Spacer(
                  flex: 3,
                ),
                RaisedButton(
                  onPressed: () {
                    //return to MainPage
                    Navigator.push(context, route1);
                  },
                  child: Text('Back'),
                ),
              ],
            ),
          ),
        )

      ),
    );
  }
}
