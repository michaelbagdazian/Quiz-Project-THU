import 'package:crew_brew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:crew_brew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  // ~ We have to create a new instance of AuthService
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    // ~ This function is actually just going to invoke the built-in function
    // ~ This function is called from the settings button onPressed
    // ! This can be used to change the avatar image
    void _showSettingsPanel(){
      // ~ Builder is the thing that actually builds the template that will sit inside the bottomSheet
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Text("bottom sheet"),
        );
      });
    }

    // ~ Use provider package to listen to the brew stream we defined in database
    // return StreamProvider<QuerySnapshot?>.value(
    return StreamProvider<List<Brew>?>.value(
      initialData: null,
      value: DatabaseService(uid: '').brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          // ~ Actions will be appearing on top right of the sidebar
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async{
                // ~ When this is complete, we're gonna get null value in our stream
                // ~ And then in wrapper it will be updated, so Authenticate screen will be called
                await _auth.signOut();
              },
              label: Text('logout'),
            ),
            FlatButton.icon(
                // ! This can be used to change the avatar image
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text('settings')
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
