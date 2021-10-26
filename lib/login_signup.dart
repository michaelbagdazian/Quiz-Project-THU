import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_pro/Authentication.dart';
import 'package:url_launcher/url_launcher.dart';
import 'CustomWidgets.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Registration',
          style: TextStyle(
            fontFamily: 'Lobster',
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Stack(fit: StackFit.expand, children: [
        Expanded(
          flex: 1,
          child: Image.asset(
            'assets/images/bgtop.png',
            fit: BoxFit.cover,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            //*Add the welcoming text first
            customWidgets().customText('Creat New\n Account'),
            SizedBox(
              height: size.height * 0.05,
            ),
            //*this one is a the usernameField
            customWidgets().customTextField(
                _usernameController, 'Username', size, TextInputType.name),
            //*add a space between text fields
            SizedBox(
              height: size.height * 0.02,
            ),
            customWidgets().customTextField(
                _emailController, 'E-mail', size, TextInputType.emailAddress),
            SizedBox(
              height: size.height * 0.02,
            ),
            customWidgets().customTextField(
              _passwordController,
              'Password',
              size,
              TextInputType.visiblePassword,
              obsecured: true,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            customWidgets().customTextField(
              _confirmPasswordController,
              'Confirm Password',
              size,
              TextInputType.visiblePassword,
              obsecured: true,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            //*the following row is to encapsulate checkbox with linkable text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyStatefulWidget(),
                      //*this sizedbox is to control the postion of box relative to text (horizontally)
                      SizedBox(
                        height: size.height * 0.034,
                      )
                    ]),
                RichText(
                  text: TextSpan(
                      text: 'I have read and I accept the ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Satisfy',
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                            text: '\nTerms of use ',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                //!change this to the webpage of the terms of use
                                _launchURLApp();
                              },
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 18,
                            )),
                        // ignore: prefer_const_constructors
                        TextSpan(
                          text: 'of this application ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Satisfy',
                            fontSize: 18,
                          ),
                        )
                      ]),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            RegButton('Register', Colors.orange, context)
          ],
        )
      ]),
    );
  }

  //*this should go to the terms of use page in a browser
  _launchURLApp() async {
    const url = 'https://flutterdevs.com/';
    if (await launch(url, forceSafariVC: true, forceWebView: true)) {
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget RegButton(
      String _label, Color _backgroundcolor, BuildContext _context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Authentication()
            .register(_emailController, _passwordController, _context);
      },
      label: Text(
        _label,
        style: const TextStyle(
          fontSize: 30,
          fontFamily: 'Lobster',
        ),
      ),
      backgroundColor: _backgroundcolor,
      extendedPadding: const EdgeInsets.all(40),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }
}

class LogInScreen extends StatelessWidget {
  //final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Sign In',
          style: TextStyle(
            fontFamily: 'Lobster',
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Stack(fit: StackFit.expand, children: [
        Expanded(
          flex: 1,
          child: Image.asset(
            'assets/images/bgtop.png',
            fit: BoxFit.cover,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            //*Add the welcoming text first
            customWidgets().customText('Log In to Your\n Account'),
            SizedBox(
              height: size.height * 0.05,
            ),
            customWidgets().customTextField(_emailController,
                'E-mail or Username', size, TextInputType.emailAddress),
            SizedBox(
              height: size.height * 0.02,
            ),
            customWidgets().customTextField(
              _passwordController,
              'Password',
              size,
              TextInputType.visiblePassword,
              obsecured: true,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            LoginButton('Log in', Colors.orange, context),
          ],
        )
      ]),
    );
  }

  Widget LoginButton(
      String _label, Color _backgroundcolor, BuildContext _context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Authentication().login(_emailController, _passwordController, _context);
      },
      label: Text(
        _label,
        style: const TextStyle(
          fontSize: 30,
          fontFamily: 'Lobster',
        ),
      ),
      backgroundColor: _backgroundcolor,
      extendedPadding: const EdgeInsets.all(40),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }
}

/*The Following Class is only to implement a Checkbox !! :) 
i couldn't figure anohter way to implement a checkbox inside a statless class so 
i just implemented a new statful class 
*/
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.selected,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    return Transform.scale(
      scale: 0.85, //*this controls the size of the check box
      child: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );
  }
}
