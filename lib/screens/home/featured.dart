import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeFeatured extends StatelessWidget
{
    final article;

    HomeFeatured(this.article);

    @override
    Widget build(BuildContext context) {
        final bool isImageExists = article["urlToImage"] != null;

        final _imageCover = SizedBox(
            child: isImageExists ?
                FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: article["urlToImage"],
                    height: 200.0,
                    fit: BoxFit.cover
                )
            : null,
        );

        final _title = Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                article["title"],
                style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                ),
            ),
        );

        return Container(
            padding: const EdgeInsets.all(5.0),
            child: Card(
                elevation: 5.0,
                child: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                            _imageCover,
                            _title,
                        ],
                    ),
                ),
            ),
        );
    }
}