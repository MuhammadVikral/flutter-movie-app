import 'dart:convert';

import 'package:rotten_chickens/feature/home_screen/data/initial_movie.dart';
import 'package:rotten_chickens/feature/home_screen/models/movie.dart';
import 'package:rotten_chickens/feature/home_screen/services/movie_service_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieService implements IMovieService {
  final SharedPreferences preferences;
  MovieService(
    this.preferences,
  );

  final List<dynamic> initialMovie = InitMovie().initialMovie;

  @override
  Future<void> initMovie() async {
    var movie = preferences.getString('movies');
    if (movie == null) {
      var movies = jsonEncode(initialMovie);
      preferences.setString('movies', movies);
    }
  }

  @override
  Future<List<dynamic>> fetchMovie() async {
    var movies = preferences.getString('movies');
    if (movies == null) {
      var movies = jsonEncode(initialMovie);
      preferences.setString('movies', movies);
    }
    var response = jsonDecode(movies!);
    return response;
  }

  @override
  Future<List<dynamic>> addMovie(Movie movie) async {
    var movies = preferences.getString('movies');
    var json = jsonDecode(movies!) as List;
    json.add(movie.toJson());
    preferences.setString('movies', jsonEncode(json));
    return json;
  }

  @override
  Future<List<dynamic>> editMovie(Movie movie, int i) async {
    var movies = preferences.getString('movies');
    var json = jsonDecode(movies!) as List;

    var findmovie = json.firstWhere(
      (element) {
        return element['id'] == i;
      },
    );
    json.remove(findmovie);
    json.add(movie);
    preferences.setString('movies', jsonEncode(json));
    return json;
  }

  @override
  Future<List<dynamic>> deleteMovie(Movie movie, int id) async {
    var movies = preferences.getString('movies');
    var json = jsonDecode(movies!) as List;
    json.removeWhere((element) => element['id'] == id);
    preferences.setString('movies', jsonEncode(json));
    return json;
  }
}
