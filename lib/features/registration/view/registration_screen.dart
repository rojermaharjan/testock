import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegistrationState();
  }
}

class _RegistrationState extends State<StatefulWidget> with TickerProviderStateMixin {
  TabController _tabController;


  @override
  Widget build(BuildContext context) {

  return TabBarView(
    children: <Widget>[
      getLoginForm(),
      getRegisterForm()
    ],
    controller: _tabController,
  );
  }

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();

  }

  Widget getLoginForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Welcome To Testock",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade900),
            textAlign: TextAlign.start,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,16,0,16),
            child: FractionallySizedBox(
              widthFactor: .7,
              child: TextFormField(
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,10),
            child: FractionallySizedBox(
              widthFactor: .7,
              child: TextFormField(
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
                validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Password cannot be empty';
//                          }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: FlatButton(
                onPressed: () {
//                          Navigator.pushReplacement(
//                            context,
//                            MyCustomRoute(builder: (context) => TestScreen()),
//                          );
//                            if (_loginFormKey.currentState.validate()) {
//                              // Process data.
//                            }
                },
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.black)),
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Lalezar',
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade900),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,16,0,0),
            child: Text(
              "Don't have an account?",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,5,0),
            child: GestureDetector(
              onTap: (){
                _tabController.animateTo(1,curve:Curves.elasticInOut);
                },
              child: Text(
                "Register Here",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue.shade500),
                textAlign: TextAlign.start,
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget getRegisterForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Let's Get Start",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade900),
            textAlign: TextAlign.start,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,16,0,16),
            child: FractionallySizedBox(
              widthFactor: .7,
              child: TextFormField(
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,10),
            child: FractionallySizedBox(
              widthFactor: .7,
              child: TextFormField(
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
                validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Password cannot be empty';
//                          }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: FlatButton(
                onPressed: () {
//                          Navigator.pushReplacement(
//                            context,
//                            MyCustomRoute(builder: (context) => TestScreen()),
//                          );
//                            if (_loginFormKey.currentState.validate()) {
//                              // Process data.
//                            }
                },
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.black)),
                child: Text(
                  'Register',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Lalezar',
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade900),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,16,0,0),
            child: Text(
              "Already have an account?",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800),
              textAlign: TextAlign.start,
            ),
          ),
          GestureDetector(
            onTap: (){
              _tabController.animateTo(0,curve:Curves.elasticInOut);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,5,5,0),
              child: Text(
                "Login Here",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue.shade500),
                textAlign: TextAlign.start,
              ),
            ),
          )
        ],
      ),
    );
  }


}

