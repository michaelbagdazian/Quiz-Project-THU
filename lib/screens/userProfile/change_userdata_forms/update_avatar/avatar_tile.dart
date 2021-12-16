import 'package:crew_brew/screens/userProfile/change_userdata_forms/update_avatar/one_avatar_entry.dart';
import 'package:flutter/material.dart';

class AvatarTile extends StatelessWidget {
  AvatarTile({Key? key, required this.avatar, required this.setAvatarPath}) : super(key: key);

  final Function setAvatarPath;
  final MapEntry<String, List<String>> avatar;

  OneAvatarEntry? lastTapped = null;
  Function? toggleLastTappedColor = null;

  @override
  Widget build(BuildContext context) {
    int points = 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          avatar.key[0].toUpperCase() + avatar.key.substring(1),
          style: TextStyle(fontSize: 18.0, color: Colors.grey[400]),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < 3; i++)
              OneAvatarEntry(
                  avatarPath: avatar.value[i], points: (points += 5) * i, setLastTapped: setLastTapped),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 3; i < 5; i++)
              OneAvatarEntry(
                  avatarPath: avatar.value[i], points: (points += 5) * i, setLastTapped: setLastTapped)
          ],
        )
      ],
    );
  }

  void setLastTapped(OneAvatarEntry? lastTapped, Function? toggleCollor) {
    if(toggleLastTappedColor != null){
      toggleLastTappedColor!();
    }

    this.toggleLastTappedColor = toggleCollor;
    this.lastTapped = lastTapped;

    if(lastTapped != null){
      setAvatarPath(this.lastTapped!.avatarPath);
      print(lastTapped.avatarPath);
    }else{
      setAvatarPath("");
    }
  }
}
