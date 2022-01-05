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
    double formHeight = size.height * (45/100);

    if (userData != null && user != null && !isLoading) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        height: formHeight,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'Update password',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Current password'),
                    obscureText: true,
                    validator: (val) => val!.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    onChanged: (val) {
                      setState(() => _currentPassword = val);
                    }),
                SizedBox(height: 10.0),
                TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'New password'),
                    obscureText: true,
                    validator: (val) => val!.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    onChanged: (val) {
                      setState(() => _newPassword = val);
                    }),
                SizedBox(height: 10.0),
                RaisedButton(
                    color: buttons,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
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
      return Container(height: 270.0, child: Loading());
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
