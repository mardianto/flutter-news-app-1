import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:transparent_image/transparent_image.dart';

import '../../models/article.dart';

class DetailTile extends StatelessWidget
{
    final Article article;

    DetailTile(this.article);

    @override
    Widget build(BuildContext context) {
        final _title = Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
                article.title,
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey[900],
                    letterSpacing: 0.5,
                ),
            ),
        );

        final _published = Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
                'Published ' + timeago.format(DateTime.parse(article.date), locale: 'en'),
                style: TextStyle(
                    color: Colors.blueGrey,
                ),
            ),
        );

        final _imageCover = Container(
            child: article.image != null ?
                FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: article.image,
                    width: double.infinity,
                    height: 200.0,
                    fit: BoxFit.cover,
                )
            : null,
        );

        final _description = Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
                article.description,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blueGrey[900],
                ),
            ),
        );

        return Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    _title,
                    _published,
                    _imageCover,
                    _description,
                ],
            ),
        );
    }
}
