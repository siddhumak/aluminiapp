import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController with ChangeNotifier {
  final picker = ImagePicker();

  XFile? _image;

  XFile? get image => _image;

  Future pickGalleryImage(BuildContext context) async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (PickedFile != null) {
      _image = XFile(PickedFile.path);
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (PickedFile != null) {
      _image = XFile(PickedFile.path);
    }
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      pickCameraImage(context);
                    },
                    leading: Icon(Icons.camera),
                    title: Text('Camera'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      pickGalleryImage(context);
                    },
                    leading: Icon(Icons.image),
                    title: Text('Gallery'),
                  )
                ],
              ),
            ),
          );
        });
  }
}
