import 'package:flutter/material.dart';

import 'providers/movie_provider.dart';
import 'package:bloc_rx/models/movie.dart';
import 'package:bloc_rx/blocs/movie_bloc.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MovieProvider(
      child: MaterialApp(
        title: 'BLoc Pattern using RxDart',
        theme: ThemeData(),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieBloc = MovieProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC with RxDart'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              onChanged: movieBloc.query.add,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search for a Movie',
              ),
            ),
          ),
          StreamBuilder(
            stream: movieBloc.log,
            builder: (context, snapshot) => Container(
                  child: Text(snapshot?.data ?? ''),
                ),
          ),
          Flexible(
            child: StreamBuilder(
              stream: movieBloc.results,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          child: _tileImage(snapshot.data[index].posterPath),
                        ),
                        title: Text(snapshot.data[index].title),
                        subtitle: Text(snapshot.data[index].overview),
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tileImage(String posterPath) {
    /// show poster image from network
    if (posterPath.startsWith("http")) {
      return Image.network(posterPath);
    }

    /// show default poster image
    return Image.asset(posterPath);
  }
}
