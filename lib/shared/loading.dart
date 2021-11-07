import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ! This is a loading widget, when we are waiting for something ( login/register/fetch data and etc )
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Center(
        // ~ Another spinners can be selected here https://pub.dev/packages/flutter_spinkit
        child: SpinKitChasingDots(
          color: Colors.brown,
          size: 50.0,
        ),
      ),
    );
  }
}