import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_pro/customWidgets/customButton.dart';
import 'package:test_pro/customWidgets/customText.dart';
import 'package:test_pro/customWidgets/customTextField.dart';
import 'package:test_pro/services/Authentication.dart';
import 'package:url_launcher/url_launcher.dart';

class LogInScreen extends StatelessWidget {
  final _customTextField = CustomTextField();
  final _customText = CustomText();
  final _authentication = Authentication();

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
            fontFamily: 'RobotoMono-Italic-VariableFont_wght.ttf',
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
            _customText.customText('Log In to Your\n Account'),
            SizedBox(
              height: size.height * 0.05,
            ),
            _customTextField.customTextField(
                _emailController,
                'E-mail or Username',
                size.width * 0.7,
                TextInputType.emailAddress),
            SizedBox(
              height: size.height * 0.02,
            ),
            _customTextField.customTextField(
              _passwordController,
              'Password',
              size.width * 0.7,
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
        _authentication.login(_emailController, _passwordController, _context);
      },
      label: Text(
        _label,
        style: const TextStyle(
          fontSize: 30,
          fontFamily: 'RobotoMono-Italic-VariableFont_wght.ttf',
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
