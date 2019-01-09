import 'package:flutter/material.dart';
import 'package:share/share.dart';

import './tile.dart';

class DetailPage extends StatelessWidget
{
    final article;

    DetailPage(this.article);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
                title: Text(article["title"]),
                actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                            Share.share(article["url"]);
                        },
                    ),
                ],
            ),
            body: Center(
                child: DetailTile(article),
            ),
        );
    }
}