// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, unused_label

/*
simple custom circular Avatar
feel free to change the raduis
we have to work on this later to actually be able to use whatever source to get images from it and not only from network
*/
import 'package:flutter/material.dart';

class customCircularAvatar {
  late NetworkImage _image;
  customCircularAvatar(String path) {
    _image = NetworkImage(path);
  }
  Widget getCircularAvatar() {
    return CircleAvatar(backgroundImage: _image, radius: 30);
  }
}
