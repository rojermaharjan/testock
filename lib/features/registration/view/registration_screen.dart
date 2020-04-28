import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SingInState();
  }
}

class _SingInState extends State<StatefulWidget> with TickerProviderStateMixin {
  TabController _tabController;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:  Size.fromHeight(kToolbarHeight),
        child: Container(
          color: Theme.of(context).primaryColor,
          child:SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(child: Container(),),
                TabBar(
                  tabs: <Widget>[
                    Tab(text: "Login"),
                    Tab(text: "Register"),
                  ],
                  controller: _tabController,
                  indicatorColor: Colors.yellow,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                ),
              ],
            ),
          )
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          getLoginForm(),
          getRegisterForm()
        ],
        controller: _tabController,
      ),
    );
  }

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();

  }

  Widget getLoginForm() {
//    double deviceWidth = MediaQuery.of(context).size.width;
//    double deviceHeight = MediaQuery.of(context).size.height -
//        TAB_HEADER_HEIGHT -
//        TAB_HEADER_OFFSET;
    return
         Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your username',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextFormField(
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
                              color: Colors.black),
                        )),
                  ),
                ],
              ),
    ));
  }


  Widget getRegisterForm() {

    return Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your username',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your mobile',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Mobile cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: FlatButton(
                    onPressed: () {
//                      if (_loginFormKey.currentState.validate()) {
//                        // Process data.
//                      }
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
                          color: Colors.black),
                    )),
              ),
            ],
          ),
        ));
  }

}

