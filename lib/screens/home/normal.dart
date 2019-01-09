import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:transparent_image/transparent_image.dart';

class HomeNormal extends StatelessWidget
{
    final article;

    HomeNormal(this.article);

    @override
    Widget build(BuildContext context) {
        final bool isImageExists = article["urlToImage"] != null;

        final _imageCover = SizedBox(
            child: isImageExists ?
                FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: article["urlToImage"],
                    width: 160.0,
                    height: 110.0,
                    fit: BoxFit.cover
                )
            : null,
        );

        final _published = Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            child: Text(
                "Published " + timeago.format(DateTime.parse(article["publishedAt"]), locale: "en"),
                style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey[500],
                ),
            ),
        );

        final _title = Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
                article["title"],
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                ),
            ),
        );

        return Container(
            padding: const EdgeInsets.all(5.0),
            child: Card(
                elevation: 5.0,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Container(
                            child: _imageCover,
                        ),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    _published,
                                    _title,
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}