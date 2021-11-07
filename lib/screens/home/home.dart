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
    // ~ Use provider package to listen to the brew stream we defined in database
    // ! return StreamProvider<QuerySnapshot?>.value(
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
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
