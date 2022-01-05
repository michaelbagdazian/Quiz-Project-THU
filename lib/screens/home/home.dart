//import 'dart:ffi';

import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/models/user/UserData.dart';
import 'package:crew_brew/navigationBar/menu_button.dart';
import 'package:crew_brew/navigationBar/navbar.dart';
import 'package:crew_brew/screens/userProfile/UpdateFormsWrapper.dart';
import 'package:crew_brew/services/database.dart';
import 'package:crew_brew/shared/colors.dart';
import 'package:crew_brew/shared/loading.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

// ! Information about the class:
// ~ This class represents myProfile page
// ! Use of the class:
// ~ It shows the user specific information

// ! TODOS:
// TODO Improve loading as done in welcome and sign_in with boolean loading variable

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ! States
  // ~ Here states of the profile page are defined
  int points = 0;
  String avatar = 'assets/avatars/default.png';
  String username = '';
  String email = '';
  UserData? userData = null;

  @override
  Widget build(BuildContext context) {
    /// ~ size of the screen
    Size size = MediaQuery.of(context).size;

    /// ~ sizes per widget
    double avatarSize = size.height * (12 / 100);
    double verticalPadding = size.height * (1 / 100);
    double horizontalPadding = size.width * (5 / 100);
    double dividerSize = size.height * (12 / 100);
    double fontSize = size.height *( 3 / 100);
    double sizedBoxHeight = size.height * (1 / 100);
    double inputBarWidth = size.width * (20 / 100);
    double buttonWidth = size.width * (8 / 100);

    // ! _showSettingsPanel()
    // ~ panel for updating userData
    void _showSettingsPanel(String command) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: UpdateFormsWrapper(command: command),
                color: topbar,
              ),
            );
          });
    }

    // ! Provider.of<AppUser?>(context):
    // ~ Here we listen to the stream, defined in services/auth.dart and provided by main.dart, which informs us about login state of the user
    final user = Provider.of<AppUser?>(context);

    // ! If user is logged in, proceed further
    if (user != null) {
      // ! StreamBuilder<UserData>
      // ~ StreamBuilder is a widget that builds itself based on the latest snapshot of interaction with a stream
      // ~ Information about the UserData is forwarded down the stream ONLY for this class. The stream does not go below to children elements
      // ~ If the data is changed in the DB, it is immideately reflected in the UserProfile
      return StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            // ! If there is a data for current user in the DB, then assign it to the variables, otherwise display Loading screen
            if (snapshot.hasData) {
              UserData? userData = snapshot.data;
              points = userData!.points;
              avatar = userData.avatar;
              username = userData.username;
              email = userData.email;

              return Scaffold(
                // ! NavBar():
                // ~ Here we provide NavBar for property drawer. This is our navigation bar defined in navigationBar/navBar.dart
                //backgroundColor: Colors.grey[900],
                appBar: AppBar(
                  title: Text('Home'),
                  centerTitle: true,
                  backgroundColor: topbar,
                  leading: const MenuButton(),
                  // ~ Elavation set to 0 removes the shadow ( which makes 3D effect )
                  elevation: 0.0,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.vpn_key_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () => _showSettingsPanel("password"),
                    ),
                  ],
                ),
                body: Container(
                  constraints: const BoxConstraints.expand(),
                  decoration: const BoxDecoration(
                    //* Background
                    image: DecorationImage(
                        image: AssetImage('assets/images/bgtop.png'),
                        fit: BoxFit.cover),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.fromLTRB(horizontalPadding, verticalPadding, horizontalPadding, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        // ~ This alligns everything to the left
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // ~ Make a circle image with CircleAvatar
                          Center(
                              child: InkWell(
                            onTap: () => _showSettingsPanel("avatars"),
                            child: CircleAvatar(
                              backgroundImage:
                                  // NetworkImage(
                                  //  userData.avatar),
                                  AssetImage(avatar),
                              backgroundColor: Colors.transparent,
                              radius: avatarSize,
                            ),
                          )),
                          // ~ This is a line which literally looks like divider
                          Divider(
                            // ~ This is the height between top element and bottom, not the line itself
                            height: dividerSize,
                            color: Colors.white,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              side: const BorderSide(
                                  color: Colors.transparent, width: .5),
                            ),
                            color: topbar.withOpacity(.7),
                            shadowColor: Colors.transparent,
                            //Colors.transparent,
                            elevation: 2.0,
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // * Start username field
                                  Text(
                                    'USERNAME',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // ~ This gives the spacing between the letters
                                      letterSpacing: 2.0,
                                      fontSize: fontSize
                                    ),
                                  ),
                                  // ~ Creates an empty invisible box for us of a height and width we specify
                                  // ~ we put it between the elements we want to have space in between
                                  SizedBox(height: sizedBoxHeight),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        username,
                                        style: TextStyle(
                                            color: Colors.amberAccent[200],
                                            letterSpacing: 2.0,
                                            fontSize: fontSize * 1.3,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 10.0),
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        onPressed: () =>
                                            _showSettingsPanel("username"),
                                      ),
                                    ],
                                  ),
                                  // * End username field
                                  SizedBox(height: sizedBoxHeight * 3),
                                  // * Start current level field
                                  Text(
                                    'POINTS',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // ~ This gives the spacing between the letters
                                      letterSpacing: 2.0,
                                      fontSize: fontSize,
                                    ),
                                  ),
                                  // ~ Creates an empty invisible box for us of a height and width we specify
                                  SizedBox(height: sizedBoxHeight),
                                  Text(
                                    // ~ With '$' we output the contat of the data to string
                                    '$points',
                                    style: TextStyle(
                                        color: Colors.amberAccent[200],
                                        letterSpacing: 2.0,
                                        fontSize: fontSize * 1.3,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // * End current level field
                                  SizedBox(height: sizedBoxHeight * 3),
                                  // * Start e-mail field
                                  Row(
                                    // child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10.0),
                                      Flexible(
                                        child: Text(
                                          email,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.white,
                                            fontSize: fontSize,
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        onPressed: () =>
                                            _showSettingsPanel("email"),
                                      ),
                                    ],
                                  ),
                                  // ),
                                  // * End e-mail field
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
              // ! If the user data is still fetching from DB, return Loading screen
            } else {
              return Loading();
            }
          });
      // ! If user is not logged in or data is still fetching from DB, return Loading screen
    } else {
      return Loading();
    }
  }
}
