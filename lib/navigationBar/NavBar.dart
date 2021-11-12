import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/models/user/UserData.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:crew_brew/services/database.dart';
import 'package:crew_brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final AuthService _auth = AuthService();
  String userName = 'test';
  String userEmail = 'test';
  String avatar = 'default.png';

  @override
  Widget build(BuildContext context) {
    // ! Here we access userData from the prodiver ( home for now )
    // final userData = Provider.of<UserData?>(context);
    final user = Provider.of<AppUser?>(context);

    if (user != null) {
      return StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData? userData = snapshot.data;
              userName = userData!.username;
              userEmail = userData.email;
            }
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(userName),
                    accountEmail: Text(userEmail),
                    currentAccountPicture: CircleAvatar(
                      child: ClipOval(
                        child: Image.asset(
                          'assets/menu_images/$avatar',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        image:
                            AssetImage('assets/menu_images/userBackground.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () => selectedItem(context, 'home'),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_circle_sharp),
                    title: Text('My profile'),
                    onTap: () => selectedItem(context, 'userProfile'),
                  ),
                  ListTile(
                    leading: Icon(Icons.archive),
                    title: Text('My quizzes'),
                    onTap: () => selectedItem(context, 'myQuizes'),
                  ),
                  ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Shared quizzes'),
                    // TODO Redirect to shared quizzes page
                    onTap: () => selectedItem(context, 'sharedQuizes'),
                  ),
                  Divider(
                    color: Colors.grey[500],
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text('Information'),
                    // TODO Redirect to information page
                    onTap: () => null,
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    // TODO Redirect to settings page
                    onTap: () => null,
                  ),
                  Divider(
                    color: Colors.grey[500],
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                    onTap: () async {
                      await _auth.signOut();
                      selectedItem(context, '');
                    },
                  ),
                ],
              ),
            );
          });
    } else {
      return Loading();
    }
  }

  void selectedItem(BuildContext context, String index) {
    // ~ It works similar to pushNamed, but instead of putting home on top of userProfile, it will replace home with location
    // ~ So location will no longer exist
    Navigator.pushReplacementNamed(context, '/$index');
  }
}
