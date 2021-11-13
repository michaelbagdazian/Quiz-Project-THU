import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_pro/services/Authentication.dart';
import 'package:test_pro/services/UploadImageToFireStorage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:test_pro/customWidgets/customText.dart';
import 'package:test_pro/customWidgets/customTextField.dart';

class SignUp extends StatelessWidget {
  //Just regular Objects
  final CustomTextField _customTextField = new CustomTextField();
  final CustomText _customText = CustomText();
  final _authentication = Authentication();

  //These are TextEditingController (https://api.flutter.dev/flutter/widgets/TextEditingController-class.html)
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //This lil boolean value is defined here to use it later to check whether the checkbox on the registeration page is checked or not,
  // as the name implies
  //IT is static because i kept having problems while using getters and setters to change this lil value in another class; feel free to change that if you want to
  static bool _isChecked = false;
//Constructor with nullable arguments so we don't have to pass anything when we use this class as an object
  SignUp({Key? key}) : super(key: key);
  @override
  //Main widget
  Widget build(BuildContext context) {
    //Size of the Screen which is relative
    Size size = MediaQuery.of(context).size;
    //normal old scaffold
    return Scaffold(
      //this following statement is to make sure that a keyboard on the screen won't push the whole screen up when it pops up
      resizeToAvoidBottomInset: false,
      //appbar on the registeration screen
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
      //normal ol stack; i use fit to expand the stack to fill the screen; try to change this to fill instead of expand to solve overflow problems
      body: Stack(fit: StackFit.expand, children: [
        SizedBox(
          child: Expanded(
            flex: 1,
            child: Image.asset(
              'assets/images/bgtop.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        //regular ol column
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //* you will see a lot of these sizedboxes, i use them to create a bit of an empty space between the children/widgets/components
            SizedBox(
              height: size.height * 0.05,
            ),
            //*Add the welcoming text first; as you can see i am using a customText Widget so i don't have to re-style every text on the page
            _customText.customText('Creat New\n Account'),
            //*again empty space
            SizedBox(
              height: size.height * 0.05,
            ),
            //*this one is a the usernameField
            _customTextField.customTextField(_usernameController, 'Username',
                size.width * 0.7, TextInputType.name),
            //*add a space between text fields
            SizedBox(
              height: size.height * 0.02,
            ),
            //*adding a textfield for the email
            _customTextField.customTextField(_emailController, 'E-mail',
                size.width * 0.7, TextInputType.emailAddress),
            //*again empty space
            SizedBox(
              height: size.height * 0.02,
            ),
            //*adding a textfield for the password; take a look at the code to know what the arguments are for
            _customTextField.customTextField(
              _passwordController,
              'Password',
              size.width * 0.7,
              TextInputType.visiblePassword,
              obsecured: true,
            ),
            //*again empty space
            SizedBox(
              height: size.height * 0.02,
            ),
            //*adding a textfield for the password confirmation; take a look at the code to know what the arguments are for
            _customTextField.customTextField(
              _confirmPasswordController,
              'Confirm Password',
              size.width * 0.7,
              TextInputType.visiblePassword,
              obsecured: true,
            ),
            //* *sighs*
            SizedBox(
              height: size.height * 0.02,
            ),
            //*the following row is to encapsulate checkbox with linkable text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
                //*this is to create a linkable Text; try to come up with a better solution if you want to
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
            //*the Registeration button
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

  //? this is the registeration button for the registeration page
  Widget RegButton(
      String _label, Color _backgroundcolor, BuildContext _context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        /*
          when pressed it calls the method register from _authentication class and passes the following arguments:
          _usernameController: which is a TextEditingController for the username
          _emailController:  which is a TextEditingController
          _passwordController:  which is a TextEditingController
          _confirmPasswordController:  which is a TextEditingController
          _isChecked: which is a boolean value; it is used to check if the checkbox on the registeration page is checked
          _context: is a BuildContext; it is used to pass the context from this class
        */
        _authentication.register(
            _usernameController,
            _emailController,
            _passwordController,
            _confirmPasswordController,
            _isChecked,
            _context);
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

/*********************************************
 
The Following Class is only to implement a Checkbox !! :) 
i couldn't figure anohter way to implement a checkbox inside a statless class so 
i just implemented a new statful class 
As you can see this class isn't reusable in an efficient sense but since we only need a checkbox on the registeration page,
it might not even matter

*********************************************/
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
          SignUp._isChecked = isChecked;
        },
      ),
    );
  }
}
