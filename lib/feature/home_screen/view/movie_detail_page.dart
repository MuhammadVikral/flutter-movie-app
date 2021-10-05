import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rotten_chickens/feature/home_screen/cubit/movie_cubit.dart';
import 'package:rotten_chickens/feature/home_screen/models/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotten_chickens/feature/home_screen/view/movie_input.dart';

class MovieDetailPage extends StatelessWidget {
  final String herotag;
  final int index;
  final Movie movie;
  const MovieDetailPage({
    Key? key,
    required this.herotag,
    required this.index,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(movie.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox(
        height: size.height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Hero(
              tag: '$herotag $index',
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10,
                child: Image.network(
                  movie.imageUrl,
                  fit: BoxFit.fill,
                  height: size.height * 0.5,
                  width: size.width,
                  errorBuilder: (context, error, stackTrace) {
                    return Lottie.asset(
                      'assets/404.json',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                movie.summary,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14.0,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: size.height * 0.005,
                left: size.width * 0.1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    heroTag: 'button',
                    onPressed: () {
                      context.read<MovieCubit>().deleteMovie(movie, movie.id);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/Home',
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  MovieInput(
                    type: MovieInputType.edit,
                    movie: movie,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
