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

    if (userData != null && user != null) {
      return Container(
        height: 170.0,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Update username',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                initialValue: userData.username,
                decoration: textInputDecoration,
                validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => setState(() => _username = val),
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                  color: buttons,
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
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
      );
    } else {
      return Loading();
    }
  }
}
