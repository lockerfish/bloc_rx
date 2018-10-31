import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bloc_rx/models/movie.dart';
import 'package:bloc_rx/auth/keys.dart';

class TheMovieDB {
  final http.Client _client = http.Client();
  String _apiKey;
  String _url;

  Future<List<Movie>> get(String query) async {
    await SecretLoader("auth/secrets.json").load().then((secret) {
      _apiKey = secret.apikey;
      _url =
          "https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&query={1}";
    });
    List<Movie> list = [];
    await _client
        .get(Uri.parse(_url.replaceFirst("{1}", query)))
        .then((res) => res.body)
        .then(json.decode)
        .then((json) => json["results"])
        .then((movies) =>
            movies.forEach((movie) => list.add(Movie.fromJson(movie))));
    return list;
  }
}
