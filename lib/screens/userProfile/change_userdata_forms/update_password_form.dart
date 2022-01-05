import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user/AppUser.dart';
import '../../../models/user/UserData.dart';
import '../../../services/database.dart';
import '../../../shared/colors.dart';
import '../../../shared/constants.dart';
import '../../../shared/customWidgets/customAlertBox.dart';
import '../../../shared/loading.dart';

class PasswordForm extends StatefulWidget {
  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentPassword = "";
  String _newPassword = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData?>(context);
    final user = Provider.of<AppUser?>(context);

    /// ~ size of the screen
    Size size = MediaQuery.of(context).size;
    double formHeight = size.height * (45 / 100);
    double fontSize = size.height * (3 / 100);
    double buttonWidth = size.width * (10 / 100);
    double inputFieldSize = size.width * (17 / 100);
    double sizedBoxHeigth = size.height * (3 / 100);

    if (userData != null && user != null && !isLoading) {
      return SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: inputFieldSize),
          height: formHeight,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Update password',
                  style: TextStyle(fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: sizedBoxHeigth),
                TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Current password', hintStyle: TextStyle(fontSize: fontSize * 0.9)),
                    obscureText: true,
                    validator: (val) => val!.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    onChanged: (val) {
                      setState(() => _currentPassword = val);
                    }),
                SizedBox(height: sizedBoxHeigth / 2),
                TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'New password', hintStyle: TextStyle(fontSize: fontSize * 0.9)),
                    obscureText: true,
                    validator: (val) => val!.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    onChanged: (val) {
                      setState(() => _newPassword = val);
                    }),
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
                        setState(() {
                          isLoading = true;
                        });
                        await DatabaseService(uid: user.uid)
                            .changePassword(_currentPassword, _newPassword,
                                userData, showError)
                            .then((value) => {
                                  setState(() {
                                    isLoading = false;
                                  }),
                                  if (value == true) Navigator.pop(context)
                                });
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

  void showError(String errorTitle, String errorMessage) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return customAlertBox(errorTitle, errorMessage);
        });
  }
}
