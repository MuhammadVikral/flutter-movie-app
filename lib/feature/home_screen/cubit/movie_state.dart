part of 'movie_cubit.dart';

enum MovieStatus { initial, loading, success, failed }

@freezed
class MovieState with _$MovieState {
  const factory MovieState({
    required String title,
    required MovieStatus status,
    required List<Movie> movies,
  }) = _MovieState;

  factory MovieState.initial() => const MovieState(
        title: '',
        status: MovieStatus.initial,
        movies: [],
      );
  const MovieState._();
}
