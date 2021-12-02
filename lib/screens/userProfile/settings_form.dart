import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user/AppUser.dart';
import '../../models/user/UserData.dart';
import '../../services/database.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _username = "";

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            if (userData != null) {
              return Form(
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
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter a name' : null,
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
                                _username.isEmpty
                                    ? userData.username
                                    : _username,
                                userData.email,
                                userData.avatar,
                                userData.level);
                            Navigator.pop(context);
                          }
                        }),
                  ],
                ),
              );
            } else {
              return Loading();
            }
          } else {
            return Loading();
          }
        });
  }
}
