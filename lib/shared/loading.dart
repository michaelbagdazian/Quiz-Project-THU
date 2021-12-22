import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:crew_brew/shared/colors.dart';

// ! Information about the class:
// ~ This class just shows spinning loading widget
// ! Use of the class:
// ~ Whenever we wait for some response from Firebase or Firestore, we use this widget

// ! TODOs
// all done

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: loading1,
      child: const Center(
        // ~ Another spinners can be selected here https://pub.dev/packages/flutter_spinkit
        child: SpinKitSpinningLines(
          color: loading2,
          size: 200.0,
        ),
      ),
    );
  }
}
