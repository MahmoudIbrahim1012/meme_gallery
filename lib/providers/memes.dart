import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meme_gallery/helpers/db_helper.dart';
import 'package:meme_gallery/models/meme.dart';

class Memes with ChangeNotifier {
  List<Meme> _items = [];

  List<Meme> get items => [..._items];

  void addMeme(Meme meme) async {
    _items.add(meme);
    notifyListeners();
    DBHelper.insert({
      'id': meme.id,
      'description': meme.description,
      'image': meme.image.path,
    });
  }

  Future<void> fetchMemes() async {
    final data = await DBHelper.getData();
    _items = data
        .map(
          (item) => Meme(
            id: item['id'],
            description: item['description'],
            image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
  void removeMeme(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    DBHelper.remove(id);
  }

}
