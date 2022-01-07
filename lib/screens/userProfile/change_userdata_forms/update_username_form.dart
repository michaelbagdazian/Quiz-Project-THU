import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user/AppUser.dart';
import '../../../models/user/UserData.dart';
import '../../../services/database.dart';
import '../../../shared/colors.dart';
import '../../../shared/constants.dart';
import '../../../shared/loading.dart';

class UsernameForm extends StatefulWidget {
  @override
  _UsernameFormState createState() => _UsernameFormState();
}

class _UsernameFormState extends State<UsernameForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _username = "";

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData?>(context);
    final user = Provider.of<AppUser?>(context);

    /// ~ size of the screen
    Size size = MediaQuery.of(context).size;
    double formHeight = size.height * (35 / 100);
    double fontSize = size.height * (3 / 100);
    double buttonWidth = size.width * (10 / 100);
    double inputFieldSize = size.width * (17 / 100);
    double sizedBoxHeigth = size.height * (3 / 100);

    if (userData != null && user != null) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: inputFieldSize),
          height: formHeight,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Update username',
                  style: TextStyle(fontSize: fontSize, color: Colors.white),
                ),
                SizedBox(height: sizedBoxHeigth),
                TextFormField(
                  style: TextStyle(fontSize: fontSize * 0.9),
                  initialValue: userData.username,
                  decoration: textInputDecoration,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _username = val),
                ),
                SizedBox(height: sizedBoxHeigth),
                FloatingActionButton.extended(
                    label: const Text(
                      'Update',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Lobster',
                          color: Colors.white),
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    backgroundColor: buttons,
                    extendedPadding: EdgeInsets.all(buttonWidth),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _username.isEmpty ? userData.username : _username,
                            userData.email,
                            userData.avatar,
                            userData.points);
                        Navigator.pop(context);
                      }
                    }),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(height: formHeight, child: Loading());
    }
  }
}
