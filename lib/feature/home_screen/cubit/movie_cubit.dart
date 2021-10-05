import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rotten_chickens/feature/home_screen/models/movie.dart';
import 'package:rotten_chickens/feature/home_screen/services/movie_service_implementation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'movie_cubit.freezed.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieState.initial());

  void init() async {
    var preference = await _initPreference();

    await MovieService(preference).initMovie();
  }

  void fetchData() async {
    emit(
      state.copyWith(
        status: MovieStatus.loading,
      ),
    );
    var data = await MovieService(await _initPreference()).fetchMovie();
    var movies = data.map((e) => Movie.fromJson(e)).toList();
    emit(
      state.copyWith(
        status: MovieStatus.success,
        movies: movies,
      ),
    );
  }

  void addMovie(Movie movie) async {
    var data = await MovieService(await _initPreference()).addMovie(movie);
    var movies = data.map((e) => Movie.fromJson(e)).toList();
    emit(
      state.copyWith(
        status: MovieStatus.success,
        movies: movies,
      ),
    );
  }

  void editMovie(Movie movie, int id) async {
    var data = await MovieService(await _initPreference()).editMovie(movie, id);
    var movies = data.map((e) => Movie.fromJson(e)).toList();
    emit(
      state.copyWith(
        status: MovieStatus.success,
        movies: movies,
      ),
    );
  }

  void deleteMovie(Movie movie, int index) async {
    var data =
        await MovieService(await _initPreference()).deleteMovie(movie, index);
    var movies = data.map((e) => Movie.fromJson(e)).toList();
    emit(
      state.copyWith(
        status: MovieStatus.success,
        movies: movies,
      ),
    );
  }

  Future<SharedPreferences> _initPreference() async {
    var preference = await SharedPreferences.getInstance();

    return preference;
  }
}
