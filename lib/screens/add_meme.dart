import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_gallery/models/meme.dart';
import 'package:meme_gallery/providers/memes.dart';
import 'package:provider/provider.dart';

class AddMeme extends StatefulWidget {
  const AddMeme({Key key}) : super(key: key);
  static const routeName = 'add-meme';

  @override
  _AddMemeState createState() => _AddMemeState();
}

class _AddMemeState extends State<AddMeme> {
  File _pickedImage;
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  void addMeme() {
    final meme = Meme(id: DateTime.now().toIso8601String(), description: descriptionController.text,
        image: _pickedImage);
    Provider.of<Memes>(context, listen: false).addMeme(meme);
    Navigator.pop(context);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    try {
      setState(() {
        isLoading = true;
        _pickedImage = File(pickedImage.path);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No image was selected'),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Meme'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 120,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 275,
                  width: 400,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: !isLoading ? _pickedImage == null
                      ? Image.asset('assets/images/placeholder-image.png')
                      : Image.file(
                          _pickedImage,
                          fit: BoxFit.fill,
                        ): Image.asset('assets/images/loading.jpg'),
                ),
                TextButton.icon(
                    onPressed: () async {
                      await _pickImage();
                    },
                    icon: Icon(Icons.image_rounded),
                    label: Text('Pick an image')),
                TextField(
                  textDirection: TextDirection.rtl,
                  controller: descriptionController,

                  decoration: InputDecoration(
                    labelText: 'Meme Description',
                  ),
                ),
                SizedBox(height: 100),
                TextButton.icon(
                  onPressed: addMeme,
                  icon: Icon(Icons.check),
                  label: Text('Add Meme'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
