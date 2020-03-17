import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:testockmbl/common/widget/animated_outline_button.dart';
import 'package:testockmbl/common/widget/animated_typed_text.dart';


class TestScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
   return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
     children: <Widget>[
       AnimatedTypedText(),
       AnimatedOutlineButton(key:UniqueKey()),
       AnimatedOutlineButton(key:UniqueKey()),
       AnimatedOutlineButton(key:UniqueKey()),
       AnimatedOutlineButton(key:UniqueKey()),
     ],
   );
  }
  
}