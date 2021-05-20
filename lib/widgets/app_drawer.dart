import 'package:flutter/material.dart';
import 'package:meme_gallery/providers/memes.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Memes>(context).items;
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Categories'),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 150,
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: (ctx, index) => ListTile(
                title: Text(categories[index].toString()),
              ),
              itemCount: categories.length,
            ),
          ),
          TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.edit),
              label: Text('Add new Category'))
        ],
      ),
    );
  }
}
