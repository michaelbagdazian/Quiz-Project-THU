// ignore_for_file: file_names, non_constant_identifier_names, unnecessary_this

import 'dart:io';
import 'package:crew_brew/models/user/UserData.dart';
import 'package:crew_brew/shared/customWidgets/customAlertBox.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
This Class Is for Uploading Images to firebase storage
it has one function for now. The function is called, uploadPicture
this function allows the user to pick an image from their gallary and upload it
to a unique directory in the firebase storage
* Maybe Later we can add more methods or modify the 'uploadPicture' method to be able to upload different types of files
 */
class UploadFileToFireStorage {
  late String url =
      ''; //this is the url to the uploaded document, it gets updated when you upload the image
  /* 
  ~ The following Future/function uploads a file and returns the download url of this file or it returns and error
  ~ It takes three Optional Parameteres:
  ~ imageFile: An Image that you want to upload directly without using an image picker (this will not be used by user)
  ~ path: which is where in fireStore do you want to store the uploaded file; so the relative path would be 'UID/path/...'
  ~ offset: which is just the offset of the file name, for example file would be named offset_Unique Identifier.extension 
  */
  Future uploadPicture(
      {File? imageFile, String path = "Images", String offset = "Img"}) async {
    File? _image; //the Image you want to upload
    _image = imageFile;
    //if there is no Image file passed the user has to choose a file from their gallary (this is the default case )
    if (_image == null) {
      //the following statements call an ImagePicker which lets the user pick an image from a
      // pre-defined source (in our case it is their gallary)
      //it sets the attribute _image so now we can upload it
      final pick = await ImagePicker().pickImage(source: ImageSource.gallery);
      //check if the User has actually picked something
      if (pick != null) {
        //assing the picked file to _image
        _image = File(pick.path);
      }
    }
    //we want to get the User Id to upload their file to a unique directory
    String currentUserID = "NullUID";
    try {
      currentUserID = FirebaseAuth.instance.currentUser!.uid;
    } catch (e) {
      //these two are for debugging and can be taken out later
      print("Couldn't get the current User Id. Uploading Image to NullUID/\n");
      print("Error Message: $e");
      //creating and using an AlertBox
      customAlertBox _customAlerBox = customAlertBox("Uploading Failed", '$e');
      _customAlerBox;
    }
    //we take the date of now and convert it to milliseconds and then convert it to a string
    //this is done to create a unique name for each uploaded file
    final _imageName = DateTime.now().millisecondsSinceEpoch.toString();
    //we create a refernce which can be seen as the directory, where we want to upload file
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        //we go into the folder that is unique to the user and then to a directory called images
        .child('$currentUserID/$path')
        //we upload the image under the name offset_uniqueImageId
        .child(offset + '_' + _imageName);
    //we try to upload the file
    try {
      //upload the file to the predefined directory/reference
      await ref.putFile(_image!);
      //update the url attribute and set it to the Download url of the uploaded file
      url = await ref.getDownloadURL();
      url = url.toString();
      return url;
      //if we have an error we catch it here
    } on firebase_storage.FirebaseException catch (e) {
      //display an alert dialog with an error message
      customAlertBox _customAlerBox =
          customAlertBox("Error Uploading Image", '${e.message}');
      _customAlerBox;
    }
  }

  Future<bool> deleteFileFromFirebaseByUrl(String? urlFile,
      {UserData? userData, String path = 'Images'}) async {
    String filePath = urlFile!
        .replaceAll(
            RegExp(
                r'https://firebasestorage.googleapis.com/v0/b/daniel-brew-crew-20887.appspot.com/o/nUwOL8z8l2WuyH9pJfh97NWpfhs1%2FAvatar%2F'),
            '')
        .split('?')[0];
    print(filePath);
    print(path);
    String userUID = userData!.uid;
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        //we go into the folder that is unique to the user and then to a directory called images
        .child('$userUID/$path')
        //we upload the image under the name offset_uniqueImageId
        .child(filePath);
    try {
      await ref.delete();
      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }
}
