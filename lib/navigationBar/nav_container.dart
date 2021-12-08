import 'package:crew_brew/navigationBar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class NavContainer extends StatelessWidget {
  final Widget page;
  const NavContainer({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: const NavBar(),
      mainScreen: page,
      style: DrawerStyle.Style6,
    );
  }
}
