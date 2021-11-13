// ignore_for_file: file_names, non_constant_identifier_names, unnecessary_this

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*This Class IS for Uploading Images to firebase storage
it has one function for now. The function is called, uploadPicture
this function allows the user to pick an image from their directory and upload it
to a unique directory in the firebase storage
 */
class UploadFileToFireStorage {
  late String url =
      ''; //this is the url to the uploaded document, it gets updated when you upload the image

  //the following Future/function uploads a file and returns the download url of this file or it returns and error
  Future uploadPicture() async {
    File? _image; //the Image you want to upload
    //the following statements call an ImagePicker which lets the user pick an image from a
    // pre-defined source (in our case it is their gallary)
    //it sets the attribute _image so now we can upload it
    final pick = await ImagePicker().pickImage(source: ImageSource.gallery);
    //check if the User has actually picked something
    if (pick != null) {
      //assing the picked file to _image
      _image = File(pick.path);
    }
    //we want to get the User Id to upload their file to a unique directory
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;
    //we take the date of now and convert it to milliseconds and then convert it to a string
    //this is done to create a unique name for each uploaded file
    final _imageName = DateTime.now().millisecondsSinceEpoch.toString();
    //we create a refernce which can be seen as the directory, where we want to upload file
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        //we go into the folder that is unique to the user and then to a directory called images
        .child('$currentUserID/images')
        //we upload the image under the name Img_uniqueImageId
        .child('Img_$_imageName');
    //we try to upload the file
    try {
      //upload the file to the predefined directory/reference
      await ref.putFile(_image!);
      //update the url attribute and set it to the Download url of the uploaded file
      url = await ref.getDownloadURL();
      //if we have an error we catch it here
    } on firebase_storage.FirebaseException catch (e) {
      //display an alert dialog with an error message
      AlertDialog(
        title: const Text(
          "Error",
          style: TextStyle(
            fontFamily: 'Lobster',
            fontSize: 40,
          ),
        ),
        content: Text('${e.message}'),
      );
    }
  }
}
