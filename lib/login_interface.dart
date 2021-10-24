//import 'package:flutter/cupertino.dart';
// ignore_for_file: camel_case_types, unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'Background.dart';

class login_interface extends StatelessWidget {
  const login_interface({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingController =
        TextEditingController();
    Size size = MediaQuery.of(context).size;
    // ignore: todo
    // TODO: implement build
    return Background(
      child: Stack(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.wallpapers13.com%2Fwp-content%2Fuploads%2F2018%2F11%2FThe-Magic-Islands-of-Lofoten-Norway-Europe-winter-morning-light-landscape-Desktop-HD-Wallpaper-For-PC-Tablet-And-Mobile-3840x2160.jpg&f=1&nofb=1')
        ],
      ),
    );
  }
}

// class myLoginState extends State<login_interface> {
//   final TextEditingController _textEditingController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     // ignore: todo
//     // TODO: implement build
//     return Background(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           // SizedBox(height: size.height * 0.03),
//           // Container(
//           //   alignment: Alignment.centerLeft,
//           //   padding: EdgeInsets.symmetric(horizontal: 10),
//           //   child: TextField(
//           //     controller: _textEditingController,
//           //     decoration: InputDecoration(
//           //       enabledBorder: OutlineInputBorder(
//           //         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//           //         borderSide: BorderSide(color: Colors.grey),
//           //       ),
//           //       focusedBorder: OutlineInputBorder(
//           //           borderRadius: BorderRadius.all(Radius.circular(5.0)),
//           //           borderSide: BorderSide(color: Colors.deepPurpleAccent)),
//           //       contentPadding: EdgeInsets.all(15),
//           //       labelText: 'Enter Your Code Here',
//           //       labelStyle: TextStyle(
//           //         color: Colors.grey[900],
//           //         fontSize: 15.0,
//           //       ),
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }

/*
* *******Text Field*********
*       appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('DemoLogin'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.deepPurpleAccent)),
              contentPadding: EdgeInsets.all(15),
              labelText: 'Enter Your Code Here',
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ),
*
*
* *******button with a bar******
*
* bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
        }),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
* */
