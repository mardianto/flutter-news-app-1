import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'HomeCell.dart';
import 'Detail.dart';

class NewsAppState extends State<NewsApp>
{
    List articles = [];

    Future<List> fetchData() async {
        final url = 'https://newsapi.org/v2/everything?sources=cbs-news&apiKey=ac9ed44be725499e8d20dd80d113750f';

        final response = await http.get(url);

        if (response.statusCode == 200) {
            final map = json.decode(response.body);

            setState(() {
                articles = map['articles'];
            });
        }
    }

    createFlatButton(context, article) {
        return FlatButton(
            padding: EdgeInsets.all(0.0),
            child: HomeCell(article),
            onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detail(article),
                    ),
                );
            },
        );
    }

    createListView() {
        return Center(
            child: articles == null
                ? CircularProgressIndicator()
                : ListView.builder(
                itemCount: articles != null ? articles.length : 0,
                itemBuilder: (context, index) {
                    return createFlatButton(context, articles[index]);
                },
            ),
        );
    }

    @override
    void initState() {
        super.initState();
        fetchData();
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                appBar: AppBar(
                    title: Text("News App"),
                    actions: <Widget>[
                        IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: fetchData,
                        ),
                    ],
                ),
                body: createListView(),
            ),
        );
    }
}