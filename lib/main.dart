import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testockmbl/features/onboarding/view/onboarding_v2.dart';
import 'package:testockmbl/features/test/view/test_screen.dart';

// void main() => runApp(MyApp());
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'Onboarding',
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
            child:  Stack(children:[TestScreen()])
//            child:  getDefaultScreen(),
        ),
      )


    );
  }

  getDefaultScreen() {
    return FutureBuilder(
      future: _isUserLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        print("Future builder clousre called");
        print(snapshot.hasData);
        if (snapshot.hasData) {
          {
            if(snapshot.data)
              return TestScreen();
            else
              return OnBoardingV2();
          }
        }
        else
          return OnBoardingV2(); // or some other widget
      },
    );


  }

  Future<bool> _isUserLoggedIn() async{
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool("prefIsUserLoggedIn");
  }

}

const backgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
//      Color.fromRGBO(55, 81, 126, 1),
//      Color.fromRGBO(232, 148, 173, 1),

//      Color.fromRGBO(242, 204, 143, 1),
//      Color.fromRGBO(244, 172, 183, 1),

//      Color.fromRGBO(49, 104, 96,1),
//      Color.fromRGBO(113, 164, 160, 1),

      Color.fromRGBO(55, 81, 126,1),
      Color.fromRGBO(113, 164, 160, 1),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
);
