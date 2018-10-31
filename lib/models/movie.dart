class Movie {
  final String title, posterPath, overview;

  Movie(this.title, this.posterPath, this.overview);

  Movie.fromJson(Map json)
      : title = json['title'],
        posterPath = json['poster_path'] == null
            ? 'images/noposter.jpg'
            : "https://image.tmdb.org/t/p/w92/" + json['poster_path'],
        overview = json['overview'];
}
