import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/services/database.dart';
import 'package:crew_brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  // ! Check register.dart or sign_in.dart for description of formKey and how it is used
  final _formKey = GlobalKey<FormState>();

  // ~ Values which user can select from drop down to choose how mny sugars they want
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String _currentName = '';
  String _currentSugars = '';
  int _currentStrength = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    // ~ By using built-in stream builder we only access the stream data in this single widget.
    // ~ we only need to access it in single widget and not as before with stream provider ( e.g as in main.dart )
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          // ~ If data is available, then we return the form
          if (snapshot.hasData) {
            // ! Here we access userData from database
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    // ! here we use userData.name to put in the current name that is stored in DB
                    initialValue: userData!.name,
                    // ~ textInputDecoration is decleraed in shared/constants.dart
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  // * dropdown
                  // ! here we use userData.sugars to put in the current sugars that are stored in DB
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars.isEmpty ? userData.sugars : '0',
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text("$sugar sugars"),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => _currentSugars = val.toString());
                    },
                  ),
                  // * slider
                  // ! here we use userData.strength to put in the current strength that is stored in DB
                  Slider(
                    value: (_currentStrength < 100 ? userData.strength : _currentStrength )
                        .toDouble(),
                    // ~ The strength of the color is increasing when we move the slider to the right
                    activeColor: Colors
                        .brown[_currentStrength < 100 ? userData.strength : _currentStrength],
                    inactiveColor: Colors
                        .brown[_currentStrength < 100 ? userData.strength : _currentStrength],
                    // ~ min value is 100, max is 900
                    min: 100,
                    max: 900,
                    // ~ in total we have 8 divisions when moving slider
                    divisions: 8,
                    // ~ Round rounds up the value to closest integer ( e.g if it's 295 it will return 300 )
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        // ! Save the data into Firestore DB
                        // ~ we are gonna use updateUserData declared in services/database.dart
                        if(_formKey.currentState!.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars.isEmpty ? userData.sugars : _currentSugars,
                            _currentName.isEmpty ? userData.name : _currentName,
                            _currentStrength < 100 ? userData.strength : _currentStrength,
                          );
                        }
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
