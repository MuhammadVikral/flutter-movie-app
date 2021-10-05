// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'movie_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MovieStateTearOff {
  const _$MovieStateTearOff();

  _MovieState call(
      {required String title,
      required MovieStatus status,
      required List<Movie> movies}) {
    return _MovieState(
      title: title,
      status: status,
      movies: movies,
    );
  }
}

/// @nodoc
const $MovieState = _$MovieStateTearOff();

/// @nodoc
mixin _$MovieState {
  String get title => throw _privateConstructorUsedError;
  MovieStatus get status => throw _privateConstructorUsedError;
  List<Movie> get movies => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MovieStateCopyWith<MovieState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieStateCopyWith<$Res> {
  factory $MovieStateCopyWith(
          MovieState value, $Res Function(MovieState) then) =
      _$MovieStateCopyWithImpl<$Res>;
  $Res call({String title, MovieStatus status, List<Movie> movies});
}

/// @nodoc
class _$MovieStateCopyWithImpl<$Res> implements $MovieStateCopyWith<$Res> {
  _$MovieStateCopyWithImpl(this._value, this._then);

  final MovieState _value;
  // ignore: unused_field
  final $Res Function(MovieState) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? status = freezed,
    Object? movies = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MovieStatus,
      movies: movies == freezed
          ? _value.movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<Movie>,
    ));
  }
}

/// @nodoc
abstract class _$MovieStateCopyWith<$Res> implements $MovieStateCopyWith<$Res> {
  factory _$MovieStateCopyWith(
          _MovieState value, $Res Function(_MovieState) then) =
      __$MovieStateCopyWithImpl<$Res>;
  @override
  $Res call({String title, MovieStatus status, List<Movie> movies});
}

/// @nodoc
class __$MovieStateCopyWithImpl<$Res> extends _$MovieStateCopyWithImpl<$Res>
    implements _$MovieStateCopyWith<$Res> {
  __$MovieStateCopyWithImpl(
      _MovieState _value, $Res Function(_MovieState) _then)
      : super(_value, (v) => _then(v as _MovieState));

  @override
  _MovieState get _value => super._value as _MovieState;

  @override
  $Res call({
    Object? title = freezed,
    Object? status = freezed,
    Object? movies = freezed,
  }) {
    return _then(_MovieState(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MovieStatus,
      movies: movies == freezed
          ? _value.movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<Movie>,
    ));
  }
}

/// @nodoc

class _$_MovieState extends _MovieState {
  const _$_MovieState(
      {required this.title, required this.status, required this.movies})
      : super._();

  @override
  final String title;
  @override
  final MovieStatus status;
  @override
  final List<Movie> movies;

  @override
  String toString() {
    return 'MovieState(title: $title, status: $status, movies: $movies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MovieState &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.movies, movies) ||
                const DeepCollectionEquality().equals(other.movies, movies)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(movies);

  @JsonKey(ignore: true)
  @override
  _$MovieStateCopyWith<_MovieState> get copyWith =>
      __$MovieStateCopyWithImpl<_MovieState>(this, _$identity);
}

abstract class _MovieState extends MovieState {
  const factory _MovieState(
      {required String title,
      required MovieStatus status,
      required List<Movie> movies}) = _$_MovieState;
  const _MovieState._() : super._();

  @override
  String get title => throw _privateConstructorUsedError;
  @override
  MovieStatus get status => throw _privateConstructorUsedError;
  @override
  List<Movie> get movies => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MovieStateCopyWith<_MovieState> get copyWith =>
      throw _privateConstructorUsedError;
}
