import 'package:flutter/material.dart';
import 'package:meme_gallery/providers/memes.dart';
import 'package:meme_gallery/widgets/image_preview.dart';
import 'package:provider/provider.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    var image = Provider.of<Memes>(context, listen: false)
        .items
        .firstWhere(
            (element) => element.description == selectedResult)
        .image;
    var id = Provider.of<Memes>(context, listen: false)
        .items
        .firstWhere(
            (element) => element.description == selectedResult)
        .id;
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(selectedResult, style: TextStyle(fontSize: 24),),
            ImagePreview(image: image, id: id),
          ],
        ),
      ),
    );
  }

  final List<String> listExample;

  Search(this.listExample);

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = []
        : suggestionList
            .addAll(listExample.where((element) => element.contains(query)));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(suggestionList[index]),
        trailing: Image.file(Provider.of<Memes>(context, listen: false)
            .items
            .firstWhere(
                (element) => element.description == suggestionList[index])
            .image),
        onTap: () {
          selectedResult = suggestionList[index];
          showResults(context);
        },
      ),
    );
  }
}


