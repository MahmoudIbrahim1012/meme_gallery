import 'package:flutter/material.dart';
import 'package:meme_gallery/providers/memes.dart';
import 'package:meme_gallery/screens/add_meme.dart';
import 'package:meme_gallery/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Memes(),
      child: MaterialApp(
        title: 'Meme Gallery',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Home(),
        routes: {
          AddMeme.routeName: (ctx) => AddMeme(),

        },
      ),
    );
  }
}

