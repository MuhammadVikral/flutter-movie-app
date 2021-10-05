import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rotten_chickens/feature/home_screen/cubit/movie_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotten_chickens/feature/home_screen/models/movie.dart';
import 'package:rotten_chickens/feature/home_screen/view/movie_detail_page.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var movies = context.watch<MovieCubit>().state.movies;
    return Column(
      children: [
        _mainMovieComponent(movies, size),
        SizedBox(height: size.height * 0.05),
        _subContentComponent(size, movies),
      ],
    );
  }

  Column _subContentComponent(Size size, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height * 0.03,
          margin: EdgeInsets.only(
            left: size.width * 0.02,
          ),
          child: const FittedBox(
            child: Text(
              'Top Picks For you',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Container(
          width: size.width,
          height: size.height * 0.4,
          color: Colors.black45,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: movies.length,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onTap: () {
                  _navigate(context, movies[index], index, 'secondary');
                },
                child: Hero(
                  tag: 'secondary $index',
                  transitionOnUserGestures: true,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10,
                    child: Image.network(
                      movies[index].imageUrl,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Lottie.asset(
                          'assets/404.json',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  CarouselSlider _mainMovieComponent(List<Movie> movies, Size size) {
    return CarouselSlider.builder(
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return Container(
          width: size.width,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: GestureDetector(
            onTap: () {
              _navigate(
                context,
                movies[itemIndex],
                itemIndex,
                'main',
              );
            },
            child: Hero(
              tag: 'main $itemIndex',
              transitionOnUserGestures: true,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10,
                child: Image.network(
                  movies[itemIndex].imageUrl,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Lottie.asset(
                      'assets/404.json',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: size.height * 0.3,
        viewportFraction: 0.95,
        autoPlay: true,
      ),
    );
  }

  _navigate(
    BuildContext context,
    Movie movie,
    int index,
    String herotag,
  ) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 900),
        pageBuilder: (_, __, ___) => MovieDetailPage(
          herotag: herotag,
          movie: movie,
          index: index,
        ),
      ),
    );
  }
}
