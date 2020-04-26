import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FindPPE extends StatelessWidget {
  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      print("Can't launch url $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: new Center(
              child: new Text('COVID Essentials', textAlign: TextAlign.center)),
        ),
        body: Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text('Masks',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
            ButtonTheme(
              minWidth: 150,
              height: 75,
              child: RaisedButton(
                color: Colors.lightBlue,
                child: Text(
                    'Make your own mask! \n'
                    'Click to learn more!',
                    textAlign: TextAlign.center, style: new TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () {
                  launchURL(
                      "https://www.cdc.gov/coronavirus/2019-ncov/prevent-getting-sick/cloth-face-cover.html");
                },
              )
            ),
            Spacer(),
            Text(
              'Gloves',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            ButtonTheme(
              minWidth: 150,
              height: 75,
              child: RaisedButton(
                color: Colors.lightBlue,
                child: Text('Find some on Amazon!', style: new TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () {
                  launchURL(
                      "https://www.amazon.com/s?k=gloves+health&rh=n%3A3753541&ref=nb_sb_noss");
                },
              ),
            ),
            Spacer(),
            Text('Hand Sanitizer',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
            ButtonTheme(
              minWidth: 150,
              height: 75,
              child: RaisedButton(
                color: Colors.lightBlue,
                child: Text(
                    'Make your own hand sanitizer! \n Click to learn more!',
                    textAlign: TextAlign.center, style: new TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () {
                  launchURL(
                      "https://www.healthline.com/health/how-to-make-hand-sanitizer");
                },
              ),
            ),
            Spacer(),
          ],
        )),
      ),
    );
  }
}
