import 'dart:async';

import 'package:bloc_rx/models/movie.dart';

import 'package:rxdart/rxdart.dart';

import 'package:bloc_rx/apis/themoviedb_org.dart';

class MovieBloc {
  final TheMovieDB api;

  Stream<List<Movie>> _results = Stream.empty();
  Stream<String> _log = Stream.empty();

  ReplaySubject<String> _query = ReplaySubject<String>();

  Stream<String> get log => _log;
  Stream<List<Movie>> get results => _results;
  Sink<String> get query => _query;

  MovieBloc(this.api) {
    _results = _query.distinct().asyncMap(api.get).asBroadcastStream();

    _log = Observable(results)
        .withLatestFrom(_query.stream, (_, query) => 'Results for $query');
  }

  void dispose() {
    _query.close();
  }
}
