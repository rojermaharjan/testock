import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegistrationState();
  }
}

class _RegistrationState extends State<StatefulWidget>
    with TickerProviderStateMixin {
  TabController _tabController;

  AnimationController _enterAnimationController;

  Animation<double> _slideAnimationDelayed1;
  Animation<double> _slideAnimationDelayed2;
  Animation<double> _slideAnimationDelayed3;
  Animation<double> _slideAnimationDelayed4;
  Animation<double> _slideAnimationDelayed5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
      child: TabBarView(
        children: <Widget>[getLoginForm(), getRegisterForm()],
        controller: _tabController,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _enterAnimationController = new AnimationController(
        duration: Duration(milliseconds: 2000),
        vsync: this,
        upperBound: 1,
        lowerBound: 0);

    _slideAnimationDelayed1 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            curve: Interval(0, .2, curve: Curves.fastOutSlowIn),
            parent: _enterAnimationController));


    _slideAnimationDelayed2 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            curve: Interval(.1, .3, curve: Curves.fastOutSlowIn),
            parent: _enterAnimationController));


    _slideAnimationDelayed3 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            curve: Interval(.2, .4, curve: Curves.fastOutSlowIn),
            parent: _enterAnimationController));



    _slideAnimationDelayed4 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            curve: Interval(.3, .5, curve: Curves.fastOutSlowIn),
            parent: _enterAnimationController));


    _slideAnimationDelayed5 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            curve: Interval(.4, .6, curve: Curves.fastOutSlowIn),
            parent: _enterAnimationController));


    _enterAnimationController.addListener(() {
      setState(() {});
    });

    _enterAnimationController.forward();
  }

  Widget getLoginForm() {
    return Form(
      child: AnimatedBuilder(
        animation: _enterAnimationController,
        builder: (_c, _b) {
          double _deviceWidth=MediaQuery.of(_c).size.width;
          return
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Opacity(
                opacity: _slideAnimationDelayed1.value,
                child: Transform.translate(
                  offset: Offset(_deviceWidth-(_slideAnimationDelayed1.value*_deviceWidth), 0),
                  child: Text(
                    "Welcome To Testock",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade900),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Opacity(
                opacity: _slideAnimationDelayed2.value,
                child: Transform.translate(
                  offset: Offset(_deviceWidth-(_slideAnimationDelayed2.value*_deviceWidth), 0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 22, 0, 0),
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
                ),
              ),
              Opacity(
                opacity: _slideAnimationDelayed3.value,
                child: Transform.translate(
                  offset: Offset(_deviceWidth-(_slideAnimationDelayed3.value*_deviceWidth), 0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 11, 0, 10),
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
                ),
              ),
              Opacity(
                opacity: _slideAnimationDelayed4.value,
                child: Transform.translate(
                  offset: Offset(_deviceWidth-(_slideAnimationDelayed4.value*_deviceWidth), 0),
                  child: Padding(
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
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 19,
                                fontFamily: 'Lalezar',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade900),
                          ),
                        )),
                  ),
                ),
              ),
              Opacity(
                opacity: _slideAnimationDelayed5.value,
                child: Transform.translate(
                  offset: Offset(_deviceWidth-(_slideAnimationDelayed5.value*_deviceWidth), 0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: _slideAnimationDelayed5.value,
                child: Transform.translate(
                  offset: Offset(_deviceWidth-(_slideAnimationDelayed5.value*_deviceWidth), 0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
                    child: GestureDetector(
                      onTap: () {
                _tabController.animateTo(1, curve: Curves.elasticInOut);

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
                  ),
                ),
              )
            ],
          );
        },
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
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade900),
            textAlign: TextAlign.start,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 22, 0, 0),
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
            padding: const EdgeInsets.fromLTRB(0, 11, 0, 10),
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
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
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
            onTap: () {
              _tabController.animateTo(0, curve: Curves.elasticInOut);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
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

  List<Widget> getAnimatedLoginForm() {}
}
