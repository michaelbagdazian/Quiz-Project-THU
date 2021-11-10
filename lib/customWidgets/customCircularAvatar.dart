// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, unused_label

/*
simple custom circular Avatar
feel free to change the raduis
*/
import 'package:flutter/material.dart';

class customCircularAvatar {
  late AssetImage _assetImage;
  customCircularAvatar(String path) {
    _assetImage = AssetImage(path);
  }
  CircularAvatar() {
    backgroundImage:
    _assetImage;
    raduis:
    30;
  }
}
