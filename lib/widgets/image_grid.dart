import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meme_gallery/providers/memes.dart';
import 'package:meme_gallery/widgets/image_preview.dart';
import 'package:provider/provider.dart';

class ImageGrid extends StatefulWidget {
  const ImageGrid({Key key}) : super(key: key);

  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  @override
  Widget build(BuildContext context) {
    var memes = Provider.of<Memes>(context).items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) => ImagePreview(
        image: memes[index].image,
        id: memes[index].id,
      ),
      itemCount: memes.length,
    );
  }
}
