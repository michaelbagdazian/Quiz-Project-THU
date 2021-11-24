import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/models/user/UserData.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:crew_brew/services/database.dart';
import 'package:crew_brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ! Information about the class:
// ~ This class is the navigation bar which you can access by clicking on 3 stripes on the top left side.
// ! Use of the class:
// ~ This class is used to navigate between different screens of the application

// ! TODOS:
// TODO If after some time fetch of the AppUser or UserData was not succesful, display error message
// TODO Improve loading as done in welcome and sign_in with boolean loading variable

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  // ! AuthService instance:
  // ~ We need this instance to check wether use is logged-in
  final AuthService _auth = AuthService();

  // ~ If user is not logged in, we use default values ( but we should not see these values in reality, because access to NavBar is granted on login )
  // ~ So if these values are seen, there is a problem
  String userName = '';
  String userEmail = '';
  String avatar = '';

  @override
  Widget build(BuildContext context) {
    // ! Provider.of<AppUser?>(context):
    // ~ Here we listen to the stream, defined in services/auth.dart and provided by main.dart, which informs us about login state of the user
    final user = Provider.of<AppUser?>(context);

    // ! If user is logged in, display the NavBar
    if (user != null) {
      // ! StreamBuilder<UserData>
      // ~ StreamBuilder is a widget that builds itself based on the latest snapshot of interaction with a stream
      // ~ Information about the UserData is forwarded down the stream ONLY for this class. The stream does not go below to children elements
      // ~ If the data is changed in the DB, it is immideately reflected in the NavBar
      return StreamBuilder<UserData>(
          // ~ Here we access the data provided in the stream, which is userData ( see user/UserData.dart to view accesable information )
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            // ! If there is a data for current user in the DB, then assign it to the variables, otherwise display Loading screen
            if (snapshot.hasData) {
              UserData? userData = snapshot.data;
              userName = userData!.username;
              userEmail = userData.email;
              avatar = userData.avatar;

              // ! Drawer widget:
              // ~ Drawer widget is used as an additional sub-router that consists of various links to other routes (ie, pages) in the same application
              return Drawer(
                // ! ListView widget:
                // ~ ListView is the most commonly used scrolling widget. It displays its children one after another in the scroll direction.
                child: ListView(
                  padding: EdgeInsets.zero,
                  // ~ Here we define the children of our ListView
                  children: [
                    // ! UserAccountsDrawerHeader
                    // ~ A material design Drawer header that identifies the app's user. You see it on the top left side with backround, user avatar
                    // ~ and some information about the user
                    UserAccountsDrawerHeader(
                      // ~ Here properties for the user data is defined ( username and e-mail )
                      accountName: Text(userName),
                      accountEmail: Text(userEmail),
                      // ! CircleAvatar:
                      // ~ Here properties for the User Avatar are defined
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
                      // ! BoxDecoration:
                      // ~ A widget that lets you draw arbitrary graphics.
                      // ~ We use it to display the backround image of the UserAccountsDrawerHeader
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/menu_images/userBackground.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // * ====================================
                    // * Start of items listed in the drawer
                    // * ====================================
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Home'),
                      // ~ When tile is clicked, we are redirected to home page using support method defined below
                      onTap: () => selectedItem(context, 'home'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.account_circle_sharp),
                      title: const Text('My profile'),
                      onTap: () => selectedItem(context, 'userProfile'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.archive),
                      title: const Text('My quizzes'),
                      onTap: () => selectedItem(context, 'myQuizes'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.share),
                      title: const Text('Shared quizzes'),
                      onTap: () => selectedItem(context, 'sharedQuizes'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.ac_unit_sharp),
                      title: const Text('Test Quiz'),
                      onTap: () => selectedItem(context, 'quizWrapper'),
                    ),
                    // ! Divider is used to separate different section of the NavBar
                    Divider(
                      color: Colors.grey[500],
                    ),
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: const Text('Information'),
                      // TODO Redirect to information page
                      onTap: () => null,
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Settings'),
                      // TODO Redirect to settings page
                      onTap: () => null,
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                    ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text('Logout'),
                      // ~ When Logout is selected, we peform signOut defined in services/auth.dart. We wait until the action was succesful and then redirect to Wrapper
                      // ~ Which then decides which screen to display ( will display Authentiaction screen )
                      onTap: () {
                        _auth.signOut();
                        selectedItem(context, '');
                      },
                    ),
                    // * ====================================
                    // * End of items listed in the drawer
                    // * ====================================
                  ],
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

  // ! This is helper method, which is used in all onTap in the ListTile
  void selectedItem(BuildContext context, String index) {
    // ! pushReplacementNamed:
    // ~ Push means that we push the screen on top of the current screen
    // ~ Replacement means that we do not current screen on stack, but instead replace the pushed screen with current screen
    // ~ Named means that we are using routing defined in main.dart
    Navigator.pushReplacementNamed(context, '/$index');
  }
}
