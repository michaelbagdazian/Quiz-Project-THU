import 'dart:collection';

import 'package:crew_brew/screens/userProfile/change_userdata_forms/update_avatar/avatar_tile.dart';
import 'package:crew_brew/services/UploadImageToFireStorage.dart';
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
  String _avatarPath = "";

  @override
  Widget build(BuildContext context) {
    /// ~ size of the screen
    Size size = MediaQuery.of(context).size;
    double formHeight = size.height * (60/100);
    double buttonWidth = size.width * (10/100);

    final userData = Provider.of<UserData?>(context);
    final user = Provider.of<AppUser?>(context);

    if (userData != null && user != null) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        height: formHeight,
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
                    return AvatarTile(
                        avatar: avatars.entries.elementAt(index),
                        setAvatarPath: setAvatarPath);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: FloatingActionButton.extended(
                        label: const Text(
                          'Update',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Lobster',
                              color: Colors.white),
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        backgroundColor: buttons,
                        extendedPadding: EdgeInsets.all(buttonWidth),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                userData.username,
                                userData.email,
                                _avatarPath.isEmpty
                                    ? userData.avatar
                                    : _avatarPath,
                                userData.points);
                            Navigator.pop(context);
                          }
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Loading();
    }
  }

  void setAvatarPath(String avatarPath) {
    _avatarPath = avatarPath;
  }
}

LinkedHashMap<String, List<String>> getAvatarsList() {
  LinkedHashMap<String, List<String>> avatars = LinkedHashMap();

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
    avatarsList.add("assets/avatars/" +
        avatarName +
        "/" +
        avatarName +
        i.toString() +
        ".png");
  }

  return avatarsList;
}
