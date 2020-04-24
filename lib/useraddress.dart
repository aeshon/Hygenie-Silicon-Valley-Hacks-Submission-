import 'package:flutter/material.dart';

class UserAddress extends StatefulWidget {
  UserAddress({Key key}) : super(key: key);

  @override
  UserAddressState createState() => new UserAddressState();
}

class UserAddressState extends State<UserAddress> {
  final formKey = GlobalKey<FormState>();
  String userAddress = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Center(
              child: new Text('Location', textAlign: TextAlign.center)),
        ),
        body: Card(
          child: new Column(
            children: <Widget>[
              Spacer(
                flex: 2,
              ),
              Text("Please enter your address to configure location settings",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              Spacer(),
              Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Address:'),
                      onSaved: (input) => userAddress = input,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              printAddress();
                            },
                            child: Text('Submit'),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ));
  }

  void printAddress() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(userAddress);
    }
  }
}
