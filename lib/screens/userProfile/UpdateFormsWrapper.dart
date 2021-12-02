import 'package:crew_brew/screens/userProfile/change_userdata_forms/update_email_form.dart';
import 'package:crew_brew/screens/userProfile/change_userdata_forms/update_password_form.dart';
import 'package:crew_brew/screens/userProfile/change_userdata_forms/update_username_form.dart';
import 'package:crew_brew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/models/user/AppUser.dart';

import '../../models/user/UserData.dart';
import '../../shared/loading.dart';

// ! Information about the class:
// ~ This class acts as wrapper for Welcome() and Home()
// ! Use of the class:
// ~ It decides whever to output Home or Welcome screen
// ~ So if you close the app without logging out ( remove the app from the RAM ), next time you will still be logged in

// ! TODOS:
// all done

class UpdateFormsWrapper extends StatelessWidget {
  final String command;

  const UpdateFormsWrapper({Key? key, required this.command}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget selectedForm = Loading();
    if(this.command == "password"){
      selectedForm = PasswordForm();
    }else if(this.command == "email"){
      selectedForm = EmailForm();
    }else if(this.command == "username"){
      selectedForm = UsernameForm();
    }

    final user = Provider.of<AppUser?>(context);

    return StreamProvider<UserData?>.value(
      value: DatabaseService(uid: user!.uid).userData,
      initialData: null,
      child: selectedForm
    );
  }
}
