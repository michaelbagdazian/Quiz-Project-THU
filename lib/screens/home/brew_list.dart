import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/models/brew.dart';

// ! This widget is responsible for outputting different brews on the page
class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    // ~ We access the brews. It's updated when some changes to the database occur
    final brews = Provider.of<List<Brew>>(context);
    brews.forEach((brew) {
      print(brew.name);
      print(brew.sugars);
      print(brew.strength);
    });

    //print(brews?.docs.toString());
    /* ! final brews = Provider.of<QuerySnapshot?>(context);
    if(brews?.docs != null ){
      for(var doc in brews!.docs){
        print(doc.data());
      }
    }
     */

    return Container();
  }
}
