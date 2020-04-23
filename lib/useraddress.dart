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
          title: new Text("Address"),
        ),
        body: Card(
          child: new Column(
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Address:'),
                      //validator: (input) =>
                      // !input.contains('@') ? 'Not a valid Email' : null,
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
