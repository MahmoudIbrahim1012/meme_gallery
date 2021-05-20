import 'dart:io';

class Meme {
  String id;
  File image;
  String description;
  Meme({this.id, this.image, this.description});

  @override
  String toString() {
    return "id: $id - description: $description";
  }
}