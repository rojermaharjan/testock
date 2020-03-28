import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testockmbl/features/test/model/question_models.dart';

class TestSummary extends StatelessWidget {
  VoidCallback onSummaryReviewed;

  Summary summaryDetail;

  TestSummary({@required this.summaryDetail, @required this.onSummaryReviewed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
        type: MaterialType.transparency,
        child: Align(
          alignment: Alignment.center,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.black.withOpacity(.6), borderRadius: BorderRadius.circular(15)),
            child:
            Padding(padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.all(10),
                  child:
                      Text('RESULT ',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Lalezar',
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),

                ),

                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('TOTAL QUESTION : ',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Lalezar',
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                      Text(summaryDetail.totalQuestions.toString(),
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Lalezar',
                              fontWeight: FontWeight.w400,
                              color: Colors.white))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('CORRECT ANSWERED : ',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Lalezar',
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                      Text(summaryDetail.correctAnswers.toString(),
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Lalezar',
                              fontWeight: FontWeight.w400,
                              color: Colors.white))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('INCORRECT ANSWERED : ',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Lalezar',
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                      Text(summaryDetail.incorrectAnswers.toString(),
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Lalezar',
                              fontWeight: FontWeight.w400,
                              color: Colors.white))
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onSummaryReviewed();
                        },
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Colors.grey.shade200)),
                        child: Text(
                          'Okay',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Lalezar',
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        )))
              ],
            )
            )
           ,
          ),
        ));
  }
}
