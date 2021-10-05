import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rotten_chickens/feature/home_screen/data/initial_movie.dart';
import 'package:rotten_chickens/feature/home_screen/models/movie.dart';
import 'package:rotten_chickens/feature/home_screen/services/movie_service_implementation.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late MovieService service;
  late SharedPreferences preference;
  final List<dynamic> initialMovie = InitMovie().initialMovie;

  setUp(
    () async {
      var movies = jsonEncode(initialMovie);
      SharedPreferences.setMockInitialValues(
        {
          'movies': movies,
        },
      );
      preference = await SharedPreferences.getInstance();
      service = MovieService(preference);
    },
  );
  tearDown(
    () async => {
      preference.remove('movies'),
    },
  );

  group(
    'Movie',
    () {
      Movie newestMovie = const Movie(
        id: 1,
        title: 'Squid Game',
        summary: 'Benteng Takeshi Campur PUBG',
        imageUrl: 'http:/http',
      );
      test(
        'should empty when app first started',
        () async {
          SharedPreferences.setMockInitialValues(
            {},
          );
          preference = await SharedPreferences.getInstance();
          var pref = preference.getString('movies');
          expect(pref == null, true);
        },
      );

      test(
        'should initialize movie when first started',
        () async {
          await service.initMovie();
          var pref = preference.getString('movies');
          var json = jsonDecode(pref!);

          expect(json, initialMovie);
        },
      );

      test(
        'should fetch movie from shared prefference',
        () async {
          service = MovieService(preference);
          var act = await service.fetchMovie();
          expect(act, initialMovie);
        },
      );

      test(
        'should add new movie to Shared Preference',
        () async {
          await service.addMovie(newestMovie);
          var pref = jsonDecode(preference.getString('movies')!);
          expect(
            pref!.length,
            initialMovie.length + 1,
          );
        },
      );

      test(
        'should edit movie and save it to shared preference',
        () async {
          await service.editMovie(newestMovie, 1);
          var pref = jsonDecode(preference.getString('movies')!);

          var findmovie = pref.firstWhere(
            (element) {
              return element['id'] == 1;
            },
          );
          expect(findmovie['title'], newestMovie.title);
        },
      );

      test(
        'should delete movie from Shared Preference',
        () async {
          await service.deleteMovie(newestMovie, newestMovie.id);
          var pref = jsonDecode(preference.getString('movies')!);
          expect(pref!.length, initialMovie.length - 1);
        },
      );
    },
  );
}
