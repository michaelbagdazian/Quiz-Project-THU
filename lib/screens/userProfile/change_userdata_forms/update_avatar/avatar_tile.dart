import 'package:flutter/material.dart';

class AvatarTile extends StatelessWidget {
  const AvatarTile({Key? key, required this.avatar}) : super(key: key);

  final MapEntry<String, List<Image>> avatar;

  @override
  Widget build(BuildContext context) {
    int points = 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          avatar.key,
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        SizedBox(height:15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for(int i = 0; i < 3;i++) getAvatar(avatar.value[i], (points+=2)*i),
          ],
        ),
        SizedBox(height:15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for(int i = 3; i < 5;i++) getAvatar(avatar.value[i], (points+=2)*i)
          ],
        )
      ],
    );
  }

  Column getAvatar(Image avatarImage, int points) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
                radius: 40.0,
                // ! The intensity of the color depends on the strength of the brew ( coffee )
                backgroundColor: Colors.grey[800],
                child: avatarImage
              //avatar.value[0],
            ),
            SizedBox(width: 20),
          ],
        ),
        SizedBox(height: 5),
        Text(
          "Points required: " + points.toString(),
          style: TextStyle(fontSize: 10.0, color: Colors.white),
        ),
      ],
    );
  }
}