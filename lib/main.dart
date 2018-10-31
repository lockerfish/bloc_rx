import 'package:flutter/material.dart';

import 'providers/movie_provider.dart';
import 'package:bloc_rx/pages/movie_seach.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MovieProvider(
      child: MaterialApp(
        title: 'BLoc Pattern using RxDart',
        theme: ThemeData(),
        home: MovieSearch(),
      ),
    );
  }
}
