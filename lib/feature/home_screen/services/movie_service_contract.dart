import 'package:rotten_chickens/feature/home_screen/models/movie.dart';

abstract class IMovieService {
  Future<List<dynamic>> fetchMovie();
  Future<void> initMovie();
  Future<List<dynamic>> addMovie(Movie movie);
  Future<List<dynamic>> editMovie(Movie movie, int id);
  Future<List<dynamic>> deleteMovie(Movie movie, int id);
}
