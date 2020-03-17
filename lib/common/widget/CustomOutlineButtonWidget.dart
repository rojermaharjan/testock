import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;

  const CustomOutlineButton(
      {Key key,
      this.text,
      this.onPressed,
      this.backgroundColor,
      this.borderRadius,
      this.textColor,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        color: Colors.red,
        shape: CircleBorder(),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Lalezar',
              fontWeight: FontWeight.w400,
              color: textColor),
        ));
  }

//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      decoration: BoxDecoration(
//        border: Border.all(color: borderColor, width: 2.0),
//        color: backgroundColor,
//        borderRadius: BorderRadius.circular(borderRadius),
//      ),
//      child: RawMaterialButton(
//        fillColor: backgroundColor,
//        elevation: 0,
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(borderRadius),
//        ),
//        child: Text(
//          text,
//          style: TextStyle(
//              fontFamily: 'Lalezar',
//              fontWeight: FontWeight.w400,
//              color: textColor),
//        ),
//        onPressed: onPressed,
//      ),
//    );
//  }

}
