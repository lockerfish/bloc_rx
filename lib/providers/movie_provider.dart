import 'package:bloc_rx/models/movie.dart';

import 'package:bloc_rx/blocs/movie_bloc.dart';

import 'package:flutter/widgets.dart';

import 'package:bloc_rx/apis/themoviedb_org.dart';

class MovieProvider extends InheritedWidget {
  final MovieBloc movieBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MovieBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(MovieProvider) as MovieProvider)
          .movieBloc;

  MovieProvider({Key key, MovieBloc movieBloc, Widget child})
      : this.movieBloc = movieBloc ?? MovieBloc(TheMovieDB()),
        super(child: child, key: key);
}
