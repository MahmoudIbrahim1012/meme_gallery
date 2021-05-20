import 'package:flutter/material.dart';
import 'package:meme_gallery/models/search.dart';
import 'package:meme_gallery/providers/memes.dart';
import 'package:meme_gallery/screens/add_meme.dart';
import 'package:meme_gallery/widgets/image_grid.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Future<void> _refreshMemes(BuildContext context) async {
    await Provider.of<Memes>(context, listen: false).fetchMemes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meme Gallery'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: Search(Provider.of<Memes>(context, listen: false)
                    .items
                    .map((e) => e.description)
                    .toList()),
              );
            },
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, AddMeme.routeName);
            },
            icon: Icon(Icons.add),
            label: Text(
              'Add meme',
            ),
            style: TextButton.styleFrom(primary: Colors.white),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshMemes(context),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: Provider.of<Memes>(context, listen: false).fetchMemes(),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? Image.asset('assets/images/loading.jpg')
                      : ImageGrid();
                }),
          ),
        ),
      ),
    );
  }
}
