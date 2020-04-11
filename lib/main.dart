import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testockmbl/features/onboarding/view/onboarding.dart';

// void main() => runApp(MyApp());
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  double _viewPortHeight;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testock',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
//        textTheme: GoogleFonts.latoTextTheme(
//          Theme.of(context).textTheme,
//        ),
      ),
      home:
      Scaffold(
        body:

        Container(
            height: double.infinity,
            width: double.infinity,
            decoration: backgroundDecoration,
            child:  Stack(children:[OnBoarding()])
        ),
      )


    );
  }
}

const backgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color.fromRGBO(55, 81, 126, 1),
      Color.fromRGBO(232, 148, 173, 1),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
);
