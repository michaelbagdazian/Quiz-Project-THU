import 'package:flutter/material.dart';

class customCircularAvatar {
  late AssetImage _assetImage;
  customCircularAvatar(String path) {
    this._assetImage = AssetImage(path);
  }
  CircularAvatar() {
    backgroundImage:
    _assetImage;
    raduis:
    30;
  }
}
