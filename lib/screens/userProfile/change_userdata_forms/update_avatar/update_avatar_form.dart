import 'dart:collection';

import 'package:crew_brew/screens/userProfile/change_userdata_forms/update_avatar/avatar_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/user/AppUser.dart';
import '../../../../models/user/UserData.dart';
import '../../../../services/database.dart';
import '../../../../shared/colors.dart';
import '../../../../shared/loading.dart';

class AvatarForm extends StatefulWidget {
  @override
  _AvatarFormState createState() => _AvatarFormState();
}

class _AvatarFormState extends State<AvatarForm> {
  final _formKey = GlobalKey<FormState>();
  LinkedHashMap<String, List<String>> avatars = getAvatarsList();

  // form values
  String _currentPassword = "";
  String _newEmail = "";

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData?>(context);
    final user = Provider.of<AppUser?>(context);

    if (userData != null && user != null) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        height: 400.0,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Flexible(
                child: PageView.builder(
                  // TODO Check what is this
                  scrollDirection: Axis.horizontal,
                  itemCount: avatars.length,
                  // ! itemBuilder:
                  // ~ itemBuilder is the function in itself which is going to return some kind of template or a widget tree for each item inside the list
                  itemBuilder: (context, index) {
                    return AvatarTile(avatar: avatars.entries.elementAt(index));
                  },
                ),
              ),
              RaisedButton(
                  color: buttons,
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid)
                          .changeEmail(_currentPassword, _newEmail, userData);
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

LinkedHashMap<String, List<String>> getAvatarsList() {
  LinkedHashMap<String, List<String>> avatars = new LinkedHashMap();

  avatars["aqualine"] = _createAvatars("aqualine");
  avatars["ceratops"] = _createAvatars("ceratops");
  avatars["duskpin"] = _createAvatars("duskpin");
  avatars["leafers"] = _createAvatars("leafers");
  avatars["primosaur"] = _createAvatars("primosaur");
  avatars["starky"] = _createAvatars("starky");

  return avatars;
}

List<String> _createAvatars(String avatarName) {
  List<String> avatarsList = [];

  for (int i = 1; i <= 5; i++) {
    avatarsList.add("assets/avatars/"+avatarName+"/"+avatarName+i.toString()+".png");
  }

  return avatarsList;
}
