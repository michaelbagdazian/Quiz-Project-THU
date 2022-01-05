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
    final userData = Provider.of<UserData?>(context);
    final user = Provider.of<AppUser?>(context);
    ValueNotifier<String> url = ValueNotifier<String>(
        'https://firebasestorage.googleapis.com/v0/b/daniel-brew-crew-20887.appspot.com/o/Default_Avatars%2Fceratops%2Fceratops2.png?alt=media&token=393336fa-a445-4f80-a241-084b0ebb68bd');

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
                    child: RaisedButton(
                        color: buttons,
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
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
                  //* The following button is in case we want to let the user upload their own avatar-
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 4.0),
                  //   child: RaisedButton(
                  //       color: buttons,
                  //       child: Text(
                  //         'Browse',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //       onPressed: () async {
                  //         UploadFileToFireStorage UA =
                  //             new UploadFileToFireStorage();
                  //         try {
                  //           await UA.uploadPicture(path: 'Avatar');
                  //           await UA.deleteFileFromFirebaseByUrl(
                  //               userData.avatar,
                  //               path: 'Avatar',
                  //               userData: userData);
                  //         } catch (e) {
                  //           return;
                  //         }
                  //         url.value = UA.url;
                  //         String uid = userData.uid;
                  //         DatabaseService(uid: uid).updateUserData(
                  //             userData.username,
                  //             userData.email,
                  //             UA.url,
                  //             userData.points);
                  //         Navigator.pop(context);
                  //       }),
                  //),
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
    avatarsList.add("assets/avatars/" +
        avatarName +
        "/" +
        avatarName +
        i.toString() +
        ".png");
  }

  return avatarsList;
}
