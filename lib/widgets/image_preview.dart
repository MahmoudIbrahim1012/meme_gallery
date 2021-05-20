import 'package:flutter/material.dart';
import 'package:meme_gallery/providers/memes.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    Key key,
    @required this.image,
    @required this.id,
  }) : super(key: key);

  final image;
  final id;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 300,
        child: Image.file(
          image,
          fit: BoxFit.fill,
        ),
      ),
      Positioned(
        top: 10,
        right: 10,
        child: Container(
          color: Colors.black12,
          child: IconButton(
            iconSize: 32.0,
            color: Colors.white,
            icon: Icon(Icons.share_outlined),
            onPressed: () {
              List<String> imagePath = [];
              imagePath.add(image.path);
              Share.shareFiles(imagePath);
            },
          ),
        ),
      ),
      Positioned(
        bottom: 10,
        right: 10,
        child: Container(
          color: Colors.black26,
          child: IconButton(
            iconSize: 28.0,
            color: Colors.white,
            icon: Icon(Icons.delete_outline),
            onPressed: () async {
              var dialog = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Text('Are you sure you want to proceed?'),
                        title: Text('You are about to delete a meme'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text('YES')),
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('NO')),
                        ],
                      ));
              if (dialog)
                Provider.of<Memes>(context, listen: false).removeMeme(id);
            },
          ),
        ),
      ),
    ]);
  }
}
