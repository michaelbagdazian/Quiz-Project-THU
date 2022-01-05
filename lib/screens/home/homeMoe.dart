// import 'dart:ui';
// import 'package:palette_generator/palette_generator.dart';
// import 'package:crew_brew/models/user/AppUser.dart';
// import 'package:crew_brew/models/user/UserData.dart';
// import 'package:crew_brew/navigationBar/menu_button.dart';
// import 'package:crew_brew/navigationBar/navbar.dart';
// import 'package:crew_brew/screens/quizzes/quiztile_resource/image_funktion.dart';
// import 'package:crew_brew/screens/userProfile/UpdateFormsWrapper.dart';
// import 'package:crew_brew/services/UploadImageToFireStorage.dart';
// import 'package:crew_brew/services/database.dart';
// import 'package:crew_brew/shared/colors.dart';
// import 'package:crew_brew/shared/customWidgets/customText.dart';
// import 'package:crew_brew/shared/loading.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';

// // ! Information about the class:
// // ~ This class represents myProfile page 
// //~ it is not used in the project but it could be used after it is edited
// // ! Use of the class:
// // ~ It shows the user specific information

// // ! TODOS:
// // TODO Improve loading as done in welcome and sign_in with boolean loading variable

// class Home2 extends StatefulWidget {
//   const Home2({Key? key}) : super(key: key);

//   @override
//   State<Home2> createState() => _HomeState2();
// }

// class _HomeState2 extends State<Home2> {
//   // ! States
//   // ~ Here states of the profile page are defined
//   int points = 0;
//   String avatar = 'assets/avatars/default.png';
//   String username = '';
//   String email = '';
//   UserData? userData = null;
//   late PaletteColor c;

//   ValueNotifier<String> url = ValueNotifier<String>(
//       'https://firebasestorage.googleapis.com/v0/b/daniel-brew-crew-20887.appspot.com/o/Default_Avatars%2Fceratops%2Fceratops2.png?alt=media&token=393336fa-a445-4f80-a241-084b0ebb68bd');

//   @override
//   Widget build(BuildContext context) {
//     // ! _showSettingsPanel()
//     // ~ panel for updating userData
//     void _showSettingsPanel(String command) {
//       showModalBottomSheet(
//           context: context,
//           builder: (context) {
//             return Container(
//               child: UpdateFormsWrapper(command: command),
//               color: welcomeh,
//             );
//           });
//     }

//     // ! Provider.of<AppUser?>(context):
//     // ~ Here we listen to the stream, defined in services/auth.dart and provided by main.dart, which informs us about login state of the user
//     final user = Provider.of<AppUser?>(context);

//     // ! If user is logged in, proceed further
//     if (user != null) {
//       // ! StreamBuilder<UserData>
//       // ~ StreamBuilder is a widget that builds itself based on the latest snapshot of interaction with a stream
//       // ~ Information about the UserData is forwarded down the stream ONLY for this class. The stream does not go below to children elements
//       // ~ If the data is changed in the DB, it is immideately reflected in the UserProfile
//       return StreamBuilder<UserData>(
//           stream: DatabaseService(uid: user.uid).userData,
//           builder: (context, snapshot) {
//             // ! If there is a data for current user in the DB, then assign it to the variables, otherwise display Loading screen
//             if (snapshot.hasData) {
//               UserData? userData = snapshot.data;
//               points = userData!.points;
//               avatar = userData.avatar;
//               username = userData.username;
//               email = userData.email;
//               Size size = MediaQuery.of(context).size;

//               return Scaffold(
//                 resizeToAvoidBottomInset: false,
//                 appBar: AppBar(
//                   title: const Text('Home'),
//                   centerTitle: true,
//                   backgroundColor: welcomeh,
//                   leading: const MenuButton(),
//                   // ~ Elavation set to 0 removes the shadow ( which makes 3D effect )
//                   elevation: 0.0,
//                   actions: <Widget>[
//                     IconButton(
//                       icon: const Icon(
//                         Icons.vpn_key_outlined,
//                         color: Colors.white,
//                       ),
//                       onPressed: () => _showSettingsPanel("password"),
//                     ),
//                   ],
//                 ),
//                 body: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       //* Blurry Container with blurred avatar
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0),
//                         child: FutureBuilder<PaletteGenerator>(
//                             future: _updatePaletteGenerator(userData),
//                             builder: (context,
//                                 AsyncSnapshot<PaletteGenerator> snapshot) {
//                               switch (snapshot.connectionState) {
//                                 case ConnectionState.waiting:
//                                   return Center(
//                                       child: CircularProgressIndicator());
//                                 default:
//                                   if (snapshot.hasError)
//                                     return new Text('Error: ${snapshot.error}');
//                                 // else {
//                                 //   // Color color=new Color(snapshot.data.dominantColor.color);
//                                 //   c = snapshot.data!.dominantColor!.color;
//                                 //   return new Text('color: ${c.toString()}');
//                                 // }
//                               }
//                               c = snapshot.data!.paletteColors.first;
//                               return Container(
//                                 width: size.width,
//                                 height: size.height * 0.3,
//                                 decoration: BoxDecoration(
//                                   // image: DecorationImage(
//                                   //     image: NetworkImage(userData.avatar),
//                                   //     fit: BoxFit.fill),
//                                   border:
//                                       Border.all(color: welcomeh.withAlpha(10)),
//                                   borderRadius: const BorderRadius.only(
//                                       bottomLeft: Radius.circular(10.0),
//                                       bottomRight: Radius.circular(10.0)),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: welcomeh.withAlpha(100),
//                                       blurRadius: 10.0,
//                                       spreadRadius: 0.0,
//                                     ),
//                                   ],
//                                   color: c.color,
//                                 ), //welcomeh.withOpacity(0.2)),
//                                 //* circular Avatar
//                                 child: BackdropFilter(
//                                   filter: ImageFilter.blur(
//                                       sigmaX: 5.0, sigmaY: 5.0),
//                                   child: InkWell(
//                                     onTap: () => _uploadAvatar(userData),
//                                     child: Center(
//                                       child: InkWell(
//                                         onTap: () =>
//                                             _showSettingsPanel("avatars"),
//                                         child: CircleAvatar(
//                                           backgroundImage:
//                                               NetworkImage(userData.avatar),
//                                           backgroundColor:
//                                               welcomeh.withOpacity(0),
//                                           radius: 70.0,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }),
//                       ),
//                       // Container(
//                       //   width: size.width,
//                       //   color: welcomeh,
//                       //   //elevation: 3.0,
//                       //   child: Column(
//                       //     children: [
//                       //       ListView(
//                       //         children: [Text(userData.username)],
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//               );

// /*
//               return Scaffold(
//                 // ! NavBar():
//                 // ~ Here we provide NavBar for property drawer. This is our navigation bar defined in navigationBar/navBar.dart
//                 backgroundColor: Colors.grey[900],
//                 appBar: AppBar(
//                   title: Text('Home'),
//                   centerTitle: true,
//                   backgroundColor: Colors.grey[850],
//                   leading: const MenuButton(),
//                   // ~ Elavation set to 0 removes the shadow ( which makes 3D effect )
//                   elevation: 0.0,
//                   actions: <Widget>[
//                     IconButton(
//                       icon: Icon(
//                         Icons.vpn_key_outlined,
//                         color: Colors.grey[400],
//                       ),
//                       onPressed: () => _showSettingsPanel("password"),
//                     ),
//                   ],
//                 ),
//                 body: Padding(
//                   padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       // ~ This alligns everything to the left
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         // ~ Make a circle image with CircleAvatar
//                         Center(
//                             child: InkWell(
//                           onTap: () => _showSettingsPanel("avatars"),
//                           child: CircleAvatar(
//                             backgroundImage: AssetImage(avatar),
//                             backgroundColor: Colors.grey[900],
//                             radius: 70.0,
//                           ),
//                         )),
//                         // ~ This is a line which literally looks like divider
//                         Divider(
//                           // ~ This is the height between top element and bottom, not the line itself
//                           height: 50.0,
//                           color: Colors.grey[800],
//                         ),
//                         // * Start username field
//                         Text(
//                           'USERNAME',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             // ~ This gives the spacing between the letters
//                             letterSpacing: 2.0,
//                           ),
//                         ),
//                         // ~ Creates an empty invisible box for us of a height and width we specify
//                         // ~ we put it between the elements we want to have space in between
//                         SizedBox(height: 10.0),
//                         Row(
//                           children: <Widget>[
//                             Text(
//                               username,
//                               style: TextStyle(
//                                   color: Colors.amberAccent[200],
//                                   letterSpacing: 2.0,
//                                   fontSize: 28.0,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(width: 10.0),
//                             IconButton(
//                               icon: Icon(
//                                 Icons.edit,
//                                 color: Colors.grey[400],
//                               ),
//                               onPressed: () => _showSettingsPanel("username"),
//                             ),
//                           ],
//                         ),
//                         // * End username field
//                         SizedBox(height: 30.0),
//                         // * Start current level field
//                         Text(
//                           'POINTS',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             // ~ This gives the spacing between the letters
//                             letterSpacing: 2.0,
//                           ),
//                         ),
//                         // ~ Creates an empty invisible box for us of a height and width we specify
//                         SizedBox(height: 10.0),
//                         Text(
//                           // ~ With '$' we output the contat of the data to string
//                           '$points',
//                           style: TextStyle(
//                               color: Colors.amberAccent[200],
//                               letterSpacing: 2.0,
//                               fontSize: 28.0,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         // * End current level field
//                         SizedBox(height: 30.0),
//                         // * Start e-mail field
//                         Row(
//                           children: <Widget>[
//                             Icon(
//                               Icons.email,
//                               color: Colors.grey[400],
//                             ),
//                             SizedBox(width: 10.0),
//                             Text(
//                               email,
//                               style: TextStyle(
//                                 color: Colors.grey[400],
//                                 fontSize: 18.0,
//                                 letterSpacing: 1.0,
//                               ),
//                             ),
//                             SizedBox(width: 10.0),
//                             IconButton(
//                               icon: Icon(
//                                 Icons.edit,
//                                 color: Colors.grey[400],
//                               ),
//                               onPressed: () => _showSettingsPanel("email"),
//                             ),
//                           ],
//                         ),
//                         // * End e-mail field
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//               */
//               // ! If the user data is still fetching from DB, return Loading screen
//             } else {
//               return Loading();
//             }
//           });
//       // ! If user is not logged in or data is still fetching from DB, return Loading screen
//     } else {
//       return Loading();
//     }
//   }

//   void _uploadAvatar(UserData? userData) async {
//     UploadFileToFireStorage UA = new UploadFileToFireStorage();
//     try {
//       await UA.uploadPicture(path: 'Avatar');
//       await UA.deleteFileFromFirebaseByUrl(userData!.avatar,
//           path: 'Avatar', userData: userData);
//     } catch (e) {
//       return;
//     }
//     url.value = UA.url;
//     String uid = userData.uid;
//     DatabaseService(uid: uid).updateUserData(username, email, UA.url, points);
//   }

//   Future<PaletteGenerator> _updatePaletteGenerator(UserData? userData) async {
//     PaletteGenerator paletteGenerator =
//         await PaletteGenerator.fromImageProvider(
//             NetworkImage(userData!.avatar));
//     print(paletteGenerator.dominantColor);
//     return paletteGenerator;
//   }
// }
