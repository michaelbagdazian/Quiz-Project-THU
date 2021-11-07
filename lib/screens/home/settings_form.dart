import 'package:flutter/material.dart';
import 'package:crew_brew/shared/constants.dart';

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
  String _currentSugars = '0';
  int _currentStrength = 0;

  @override
  Widget build(BuildContext context) {
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
            // ~ textInputDecoration is decleraed in shared/constants.dart
            decoration: textInputDecoration,
            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(height: 20.0),
          // * dropdown
          DropdownButtonFormField(
            decoration: textInputDecoration,
            value: _currentSugars,
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
          Slider(
            value: (_currentStrength < 100 ? 100 : _currentStrength).toDouble(),
            // ~ The strength of the color is increasing when we move the slider to the right
            activeColor: Colors.brown[_currentStrength < 100 ? 100 : _currentStrength],
            inactiveColor: Colors.brown[_currentStrength < 100 ? 100 : _currentStrength],
            // ~ min value is 100, max is 900
            min: 100,
            max: 900,
            // ~ in total we have 8 divisions when moving slider
            divisions: 8,
            // ~ Round rounds up the value to closest integer ( e.g if it's 295 it will return 300 )
            onChanged: (val) => setState(() => _currentStrength = val.round()),
          ),
          RaisedButton(
              color: Colors.pink[400],
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                print(_currentName);
                print(_currentSugars);
                print(_currentStrength);
              }
          ),
        ],
      ),
    );
  }
}
