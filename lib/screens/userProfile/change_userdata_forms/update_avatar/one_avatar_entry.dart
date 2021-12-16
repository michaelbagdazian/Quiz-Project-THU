import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/user/UserData.dart';
import '../../../../shared/loading.dart';

class OneAvatarEntry extends StatefulWidget {
  final String avatarPath;
  final int points;
  final Function setLastTapped;

  OneAvatarEntry(
      {Key,
      key,
      required this.avatarPath,
      required this.points,
      required this.setLastTapped})
      : super(key: key);

  @override
  _OneAvatarEntryState createState() => _OneAvatarEntryState();
}

class _OneAvatarEntryState extends State<OneAvatarEntry> {
  Color backgroundColor = Colors.grey[800]!;
  Color lockOpacity = Colors.redAccent.withOpacity(0.9);
  bool canSelect = false;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData?>(context);

    if (userData != null) {
      canSelect = userData.points >= widget.points;

      if (canSelect) {
        setState(() {
          lockOpacity = Colors.red.withOpacity(0.0);
        });
      }else{
        setState(() {
          lockOpacity = Colors.redAccent.withOpacity(0.9);
        });
      }

      return Column(
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  if (canSelect) {
                    print("can select");
                    if (backgroundColor == Colors.green[800]) {
                      /// ~ Unselect if user taps on the avatar which is already selected
                      widget.setLastTapped(null, null);
                    } else {
                      toggleColor();
                      widget.setLastTapped(widget, toggleColor);
                    }
                  } else {
                    print("cannot select");
                    blinkRed();
                  }
                },
                child: Stack(alignment: Alignment.center, children: [
                  CircleAvatar(
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
                  Icon(
                    Icons.lock,
                    color: lockOpacity,
                    size: 40.0,
                  )
                ]),
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
    } else {
      return Loading();
    }
  }

  void toggleColor() {
    setState(() {
      if (backgroundColor == Colors.grey[800]) {
        backgroundColor = Colors.green[800]!;
      } else {
        backgroundColor = Colors.grey[800]!;
      }
    });
  }

  Future<void> blinkRed() async {
      setState(() {
        backgroundColor = Colors.red[800]!;
      });

      await Future.delayed(Duration(milliseconds: 500));

      setState(() {
        backgroundColor = Colors.grey[800]!;
      });
    }
}
