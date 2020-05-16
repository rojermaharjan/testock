import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:testockmbl/base/base_events.dart';
import 'package:testockmbl/common/utils/utils.dart';
import 'package:testockmbl/features/registration/model/registration_models.dart';
import 'package:testockmbl/features/registration/presenter/registration_presenter.dart';
import 'package:testockmbl/features/test/view/test_screen.dart';
import 'package:testockmbl/router.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegistrationState();
  }
}

class _RegistrationState extends State<StatefulWidget>
    with TickerProviderStateMixin {
  String _registerEmail;
  String _registerPassword;
  String _registerUsername;

  String _loginEmail;
  String _loginPassword;

  TabController _tabController;

  AnimationController _enterAnimationController;

  Animation<double> _slideAnimationDelayed1;
  Animation<double> _slideAnimationDelayed2;
  Animation<double> _slideAnimationDelayed3;
  Animation<double> _slideAnimationDelayed4;
  Animation<double> _slideAnimationDelayed5;

  GlobalKey<FormState> _registerWidgetKey;
  GlobalKey<FormState> _loginWidgetKey;

  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, isDismissible: false);
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[getLoginForm(), getRegisterForm()],
        controller: _tabController,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    GetIt.I.registerSingleton<RegistrationScreenPresenter>(
        RegistrationScreenPresenter());
    _registerWidgetKey = GlobalKey<FormState>();
    _loginWidgetKey = GlobalKey<FormState>();

    _tabController = new TabController(length: 2, vsync: this);
    _enterAnimationController = new AnimationController(
        duration: Duration(milliseconds: 1800),
        vsync: this,
        upperBound: 1,
        lowerBound: 0);

    _slideAnimationDelayed1 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            curve: Interval(0, .2, curve: Curves.fastOutSlowIn),
            parent: _enterAnimationController));

    _slideAnimationDelayed2 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            curve: Interval(.05, .25, curve: Curves.fastOutSlowIn),
            parent: _enterAnimationController));

    _slideAnimationDelayed3 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            curve: Interval(.1, .3, curve: Curves.fastOutSlowIn),
            parent: _enterAnimationController));

    _slideAnimationDelayed4 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            curve: Interval(.15, .35, curve: Curves.fastOutSlowIn),
            parent: _enterAnimationController));

    _slideAnimationDelayed5 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            curve: Interval(.2, .4, curve: Curves.fastOutSlowIn),
            parent: _enterAnimationController));

    _enterAnimationController.addListener(() {
      setState(() {});
    });

    GetIt.I<RegistrationScreenPresenter>()
        .loginEventStream
        .listen((loginEvent) {
      _handleLoginEvent(loginEvent);
    });

    GetIt.I<RegistrationScreenPresenter>()
        .registerEventStream
        .listen((registerEvent) {
      _handleRegisterEvent(registerEvent);
    });

    _enterAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _enterAnimationController.dispose();
    GetIt.I.unregister<RegistrationScreenPresenter>();
  }

  Widget getLoginForm() {
    return Form(
      key: _loginWidgetKey,
      child: AnimatedBuilder(
        animation: _enterAnimationController,
        builder: (_c, _b) {
          double _deviceWidth = MediaQuery.of(_c).size.width;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform.translate(
                offset: Offset(
                    _deviceWidth -
                        (_slideAnimationDelayed1.value * _deviceWidth),
                    0),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _deviceWidth -
                        (_slideAnimationDelayed2.value * _deviceWidth),
                    0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: FractionallySizedBox(
                    widthFactor: .7,
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.grey.shade200,
                      ),
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(color: Colors.grey)),
                      onSaved: (value) {
                        this._loginEmail = value;
                      },
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
              Transform.translate(
                offset: Offset(
                    _deviceWidth -
                        (_slideAnimationDelayed3.value * _deviceWidth),
                    0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: FractionallySizedBox(
                    widthFactor: .7,
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.grey.shade200,
                      ),
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.grey)),
                      onSaved: (value) {
                        this._loginPassword = value;
                      },
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
              Transform.translate(
                offset: Offset(
                    _deviceWidth -
                        (_slideAnimationDelayed4.value * _deviceWidth),
                    0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: FlatButton(
                      onPressed: () {
                        if (_loginWidgetKey.currentState.validate()) {
                          _loginWidgetKey.currentState.save();
                          GetIt.I<RegistrationScreenPresenter>()
                              .performLogin(_loginEmail, _loginPassword);
                        }
                      },
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                          side: BorderSide(color: Colors.blue)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 19,
                              fontFamily: 'Lalezar',
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      )),
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _deviceWidth -
                        (_slideAnimationDelayed5.value * _deviceWidth),
                    0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _deviceWidth -
                        (_slideAnimationDelayed5.value * _deviceWidth),
                    0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
                  child: GestureDetector(
                    onTap: () {
                      _tabController.animateTo(1, curve: Curves.elasticInOut);
                    },
                    child: Text(
                      "Register Here",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue.shade500),
                      textAlign: TextAlign.start,
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
      key: _registerWidgetKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Let's Get Start",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Colors.white),
            textAlign: TextAlign.start,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: FractionallySizedBox(
              widthFactor: .7,
              child: TextFormField(
                textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey.shade200,
                  ),
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey)
                ),
                onSaved: (value) {
                  this._registerEmail = value;
                },
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please enter some text';
                  else if (!Utils.isEmailValid(value))
                    return "Email is not valid";
                  else
                    return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: FractionallySizedBox(
              widthFactor: .7,
              child: TextFormField(
                textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey.shade200,
                  ),
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.grey)
                ),
                onSaved: (value) {
                  this._registerPassword = value;
                },
                validator: (value) {
                  if (value.isEmpty)
                    return 'Password cannot be empty';
                  else
                    return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: FractionallySizedBox(
              widthFactor: .7,
              child: TextFormField(
                style: TextStyle(
                  color: Colors.grey.shade200,
                ),

                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your username',
                    hintStyle: TextStyle(color: Colors.grey)
                ),
                onSaved: (value) {
                  this._registerUsername = value;
                },
                validator: (value) {
                  if (value.isEmpty)
                    return 'Username cannot be empty';
                  else
                    return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: FlatButton(
                onPressed: () {
                  if (_registerWidgetKey.currentState.validate()) {
                    _registerWidgetKey.currentState.save();
                    GetIt.I<RegistrationScreenPresenter>().performRegister(
                        _registerEmail, _registerPassword, _registerUsername);
                  }
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    side: BorderSide(color: Colors.blue)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'Lalezar',
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Text(
              "Already have an account?",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
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
                    fontSize: 15,
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

  Future<void> _handleLoginEvent(UseCaseEvent<LoginModel> loginEvent) async {
    print(loginEvent.useCaseStatus);
    switch (loginEvent.useCaseStatus) {
      case UseCaseStatus.SUCCESS:
        pr.hide().then((isHidden) {
          Navigator.pushReplacement(
            context,
            MyCustomRoute(builder: (context) => TestScreen()),
          );
        });

        break;

      case UseCaseStatus.LOADING:
        pr.update(message: loginEvent.message);
        await pr.show();
        break;

      case UseCaseStatus.FAILED:
        await pr.hide();
        Fluttertoast.showToast(
            msg: loginEvent.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        break;
    }
  }

  Future<void> _handleRegisterEvent(
      UseCaseEvent<RegisterModel> registerEvent) async {
    switch (registerEvent.useCaseStatus) {
      case UseCaseStatus.SUCCESS:
        await pr.hide();
        Fluttertoast.showToast(
            msg: registerEvent.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        _tabController.animateTo(0, curve: Curves.elasticInOut);
        break;

      case UseCaseStatus.LOADING:
        pr.update(message: registerEvent.message);
        await pr.show();
        break;

      case UseCaseStatus.FAILED:
        await pr.hide();
        Fluttertoast.showToast(
            msg: registerEvent.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        break;
    }
  }
}
