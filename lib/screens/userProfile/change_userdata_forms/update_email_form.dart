import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user/AppUser.dart';
import '../../../models/user/UserData.dart';
import '../../../services/database.dart';
import '../../../shared/colors.dart';
import '../../../shared/constants.dart';
import '../../../shared/customWidgets/customAlertBox.dart';
import '../../../shared/loading.dart';

class EmailForm extends StatefulWidget {
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentPassword = "";
  String _newEmail = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData?>(context);
    final user = Provider.of<AppUser?>(context);

    if (userData != null && user != null && !isLoading) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        height: 270.0,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Update e-mail',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'new e-mail'),
                  // ~ we return null value is this formField is valid or a string
                  // ~ if it's not valid
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    // ~ We take email state and set it equal to value which is in e-mail textField
                    setState(() => _newEmail = val.trim());
                  }),
              SizedBox(height: 10.0),
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
                          .changeEmail(
                              _currentPassword, _newEmail, userData, showError)
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
      );
    } else {
      return Loading();
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
