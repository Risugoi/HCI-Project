import 'package:donation/home.dart';
import 'package:donation/login.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/services.dart';
import 'package:donation/database/dbHelper.dart';
import 'package:donation/database/feeddb.dart';
import 'package:donation/requestInfo.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, //remove debug banner
    home: Splash(),
  ));
}

//initial loading screen
class Splash extends StatelessWidget {
  Widget build(BuildContext context) {
// create databases after widget builds
    //login/signup database
    WidgetsBinding.instance.addPersistentFrameCallback(
        (_) => dbHelper.createInstance().createSignupTable());
    //feed database
    WidgetsBinding.instance.addPersistentFrameCallback(
        (_) => feeddb.createInstance().createFeedTable());

    return new SplashScreen(
      seconds: 1,
      navigateAfterSeconds: new Home(),
      title: new Text(
        "chaready",
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.asset("assets/images/logo.png"),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.green,
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //uncomment when done
    return login();
    //return home();
    //return donationRequestInfo();
  }
}
