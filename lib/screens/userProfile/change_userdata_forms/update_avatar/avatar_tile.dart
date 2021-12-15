import 'package:flutter/material.dart';

class AvatarTile extends StatelessWidget {
  const AvatarTile({Key? key, required this.avatar}) : super(key: key);

  final MapEntry<String, List<String>> avatar;

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
            for(int i = 0; i < 3; i++) getAvatar(
                avatar.value[i], (points += 5) * i),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for(int i = 3; i < 5; i++) getAvatar(
                avatar.value[i], (points += 5) * i)
          ],
        )
      ],
    );
  }

  Column getAvatar(String avatarPath, int points) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 10),
            InkWell(
              //onTap: =>,
              child: CircleAvatar(
                  radius: 45.0,
                  // ! The intensity of the color depends on the strength of the brew ( coffee )
                  backgroundColor: Colors.grey[800],
                  child: Image.asset(
                    avatarPath,
                    height: 80,
                    width: 80,
                  )
                //avatar.value[0],
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
        SizedBox(height: 5),
        Text(
          "Points required: " + points.toString(),
          style: TextStyle(fontSize: 10.0, color: Colors.grey[700]),
        ),
      ],
    );
  }

}