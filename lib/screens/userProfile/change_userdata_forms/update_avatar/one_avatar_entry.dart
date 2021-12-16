import 'package:flutter/material.dart';


class OneAvatarEntry extends StatefulWidget {
  final String avatarPath;
  final int points;
  final Function setLastTapped;

  OneAvatarEntry({Key, key, required this.avatarPath, required this.points, required this.setLastTapped}) : super(key: key);

  @override
  _OneAvatarEntryState createState() => _OneAvatarEntryState();

}

class _OneAvatarEntryState extends State<OneAvatarEntry> {
  Color backgroundColor = Colors.grey[800]!;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 10),
            InkWell(
              onTap: (){
                if(backgroundColor == Colors.green[800]){
                  /// ~ Unselect if user taps on the avatar which is already selected
                  widget.setLastTapped(null, null);
                }else{
                  toggleColor();
                  widget.setLastTapped(widget, toggleColor);
                }
              },
              child: CircleAvatar(
                  radius: 45.0,
                  // ! The intensity of the color depends on the strength of the brew ( coffee )
                  backgroundColor: backgroundColor,
                  child: Image.asset(
                    widget.avatarPath,
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
          "Points required: " + widget.points.toString(),
          style: TextStyle(fontSize: 10.0, color: Colors.grey[700]),
        ),
      ],
    );
  }

  void toggleColor (){
    setState(() {
      if(backgroundColor == Colors.grey[800]){
        backgroundColor = Colors.green[800]!;
      }else{
        backgroundColor = Colors.grey[800]!;
      }
    });
  }
}

