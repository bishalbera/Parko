import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parko/common/constants/constants.dart';

void moveScreen(BuildContext context, Widget screenName,
    {bool isPushReplacement = false}) {
  if (isPushReplacement) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => screenName));
  } else {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => screenName));
  }
}

int selectedIndex = 0;

//showSnackBar

void showSnackBar(
    BuildContext context, String title, String content, ContentType type) {
  final snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: '$title!',
      message: '$content',
      contentType: type,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

void pickImage(BuildContext context) async {
  final ImagePicker _picker = ImagePicker();
  // Pick an image
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  imageFile = File(image!.path);
}

PreferredSizeWidget makeAppBar(BuildContext context,
    {String title = "$appName"}) {
  return PreferredSize(
    preferredSize: const Size(double.infinity, kToolbarHeight),
    child: AppBar(
      title: Text(title),
      centerTitle: true,
    ),
  );
}
