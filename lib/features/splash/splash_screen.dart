import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  SharedPreferences sharedPrefs;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Asdf"),
    );


  }



  @override
  void initState() {
    super.initState();
  }
}
