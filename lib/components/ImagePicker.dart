import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(
      this.imagePickFn,
      );

  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  ImagePicker picker = ImagePicker();

  void _pickImage(ImageSource imageSource) async {
    final pickedImageFile = await picker.getImage(
      source: imageSource,
    );

    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickFn(File(pickedImageFile.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: 190,
              child: _pickedImage != null
                  ? Image(
                image: FileImage(_pickedImage),
              )
                  : Image.asset(
                  'assets/png/qr-code-scan.png',width: 45,height: 45,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        FlatButton.icon(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text(
                      'Complete your action using..',
                    ),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                        ),
                      ),
                    ],
                    content: Container(
                      height: 120,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.camera),
                            title: Text(
                              'Camera',
                            ),
                            onTap: () {
                              _pickImage(ImageSource.camera);
                              Navigator.of(context).pop();
                            },
                          ),
                          Divider(
                            height: 1,
                            color: Colors.black,
                          ),
                          ListTile(
                            leading: Icon(Icons.image),
                            title: Text(
                              'Gallery',
                            ),
                            onTap: () {
                              _pickImage(ImageSource.gallery);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          icon: Icon(Icons.add),
          label: Text(
            'Add Image',
          ),
        )
      ],
    );
  }
}