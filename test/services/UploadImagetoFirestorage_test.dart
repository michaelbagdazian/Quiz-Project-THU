// ignore_for_file: avoid_web_libraries_in_flutter, file_names

import 'dart:io' as io;

import 'package:flutter_test/flutter_test.dart';
import 'package:crew_brew/services/UploadImageToFireStorage.dart';
import 'package:http/http.dart' as http;

/*
! This class is to test Uploading an Image to firestore
! ignore this class for now because it is not fully implemented yet
! i have to work on it later
*/

void main() {
  group('Uploading an Image', () {
    test('response.statusCode should be equal to 200', () async {
      io.File? _image;
      _image = io.File('/assets/avatar/generic_robo.png');
      UploadFileToFireStorage uploadFileToFireStorage =
          UploadFileToFireStorage();
      //uploading an image to firestore
      uploadFileToFireStorage.uploadPicture(imageFile: _image);
      Uri uri;
      var url =
          uploadFileToFireStorage.url; //get download url of uploaded image
      uri = Uri.parse(url); //parse url to uri
      final response =
          await http.get(uri); //send an http post request to the download url
      int statusCode = response
          .statusCode; //we check the response's status code; if it is 200, that means the file exists
      expect(statusCode, 200);
    });
  });

  //! testing my testing method :p
  test('Testing the testing method; response.statusCode should be equal to 200',
      () async {
    String url =
        'https://firebasestorage.googleapis.com/v0/b/quizzler-13da0.appspot.com/o/QF1kGT6evVhLoQ1PCTskPfusTiJ3%2Fimages%2FImg_1636767228084?alt=media&token=2929ef7d-6b1f-4823-8911-a797c28273da';

    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    expect(response.statusCode, 200);
  });
}
