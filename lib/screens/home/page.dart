import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:connectivity/connectivity.dart';

import 'card_featured.dart';
import 'card_regular.dart';
import '../style.dart';
import '../detail/page.dart';
import '../../models/post.dart';

class HomePage extends StatefulWidget {
    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    String _connectionStatus = 'Unknown';
    final Connectivity _connectivity = Connectivity();

    Future<List<Post>> _fetchData() async {
        const apiUrl = 'https://newsapi.org/v2/everything?sources=cbs-news&apiKey=ac9ed44be725499e8d20dd80d113750f';

        var response = await http.get(apiUrl);

        if (response.statusCode == 200) {
            List posts = json.decode(response.body)['articles'];

            return posts.map((json) => Post.fromJson(json)).toList();
        }

        throw Exception('Failed to load.');
    }

    Future<Null> initConnectivity() async {
        String connectionStatus;

        try {
            connectionStatus = (await _connectivity.checkConnectivity()).toString();
        } catch (e) {
            connectionStatus = 'Unknown';
        }

        setState(() {
            _connectionStatus = connectionStatus;
        });
    }

    Widget _makeBody() {
        if (_connectionStatus != 'Unknown' && _connectionStatus != 'ConnectivityResult.none') {
            return Container(
                padding: EdgeInsets.only(
                    bottom: 12.0,
                ),
                child: Column(
                    children: <Widget>[
                        Expanded(
                            child: _makeListView(),
                        ),
                    ],
                ),
            );
        }

        return _errorMessage('Outch! It seems you\'re offline.\nPlease check your internet connection.');
    }

    FutureBuilder _makeListView() {
        return FutureBuilder(
            future: _fetchData(),
            builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                        return _errorMessage('We\'re sorry something went wrong :(');
                    }

                    return ListView.builder(
                        itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                        itemBuilder: (context, index) => _makeGesture(context, index, snapshot.data[index]),
                    );
                }

                return Center(
                    child: CircularProgressIndicator(),
                );
            },
        );
    }

    Widget _makeGesture(context, index, post) {
        return GestureDetector(
            child: index == 0 ? CardFeatured(post) : CardRegular(post),
            onTap: () {
                Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DetailPage(post),
                    ),
                );
            },
            onLongPress: () => Share.share(post.url),
        );
    }

    Widget _errorMessage(String text) {
        return Container(
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    Text(
                        text,
                        style: errorMessage,
                    ),
                ],
            ),
        );
    }

    @override
    void initState() {
        super.initState();
        initConnectivity();

        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
            setState(() {
                _connectionStatus = result.toString();
            });
        });
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: ThemeData(
                fontFamily: 'SegoeUI',
                primarySwatch: Colors.indigo,
                hintColor: Colors.indigo[400],
            ),
            home: Scaffold(
                backgroundColor: Colors.grey[100],
                appBar: AppBar(
                    title: Text('News App'),
                    actions: <Widget>[
                        IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                                setState(() {
                                    _fetchData();
                                });
                            },
                        ),
                    ],
                ),
                body: _makeBody(),
            ),
        );
    }
}
