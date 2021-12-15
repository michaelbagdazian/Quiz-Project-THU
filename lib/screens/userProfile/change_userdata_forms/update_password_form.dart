import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user/AppUser.dart';
import '../../../models/user/UserData.dart';
import '../../../services/database.dart';
import '../../../shared/colors.dart';
import '../../../shared/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData?>(context);
    final user = Provider.of<AppUser?>(context);

    if (userData != null && user != null) {
      return Container(
        height: 230.0,
        child: Form(
          key: _formKey,
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
                  validator: (val) =>
                      val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() => _currentPassword = val);
                  }),
              SizedBox(height: 10.0),
              TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'New password'),
                  obscureText: true,
                  validator: (val) =>
                      val!.length < 6 ? 'Enter a password 6+ chars long' : null,
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
                      await DatabaseService(uid: user.uid).changePassword(
                          _currentPassword, _newPassword, userData);
                      Navigator.pop(context);
                    }
                  }),
            ],
          ),
        ),
      );
    } else {
      return Loading();
    }
  }
}
