import 'package:flutter/material.dart';

class UserAddress extends StatelessWidget {
  //UserAddress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnackBar Demo',
      home: Scaffold(
        appBar: AppBar(
          title: new Center(
              child: new Text('Location', textAlign: TextAlign.center)),
        ),
        body: UserAddressState(),
      ),
    );
  }
}

class UserAddressState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
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

              final snackBar = SnackBar(
                content: Text('Location has been configured'),
              );

              Scaffold.of(context).showSnackBar(snackBar);
            },
            child: Text('Configure'),
          ),
          Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
