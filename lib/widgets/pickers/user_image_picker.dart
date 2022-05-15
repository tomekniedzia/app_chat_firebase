import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  //const UserImagePicker({ Key? key }) : super(key: key);
  UserImagePicker(this.imagePickFunction);

  final void Function(File pickedImage) imagePickFunction;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    ); //#TODO dialog where user can chose if he want use camera or galery
    final File pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickFunction(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Theme.of(context).primaryColor,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            primary: Colors.pink,
          ),
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
