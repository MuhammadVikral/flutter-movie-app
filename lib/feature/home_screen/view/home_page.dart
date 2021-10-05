import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotten_chickens/feature/auth/cubit/auth_cubit.dart';

import 'package:rotten_chickens/feature/home_screen/cubit/movie_cubit.dart';
import 'package:rotten_chickens/feature/home_screen/view/home_page_content.dart';
import 'package:rotten_chickens/feature/home_screen/view/movie_input.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: const Text('Rotten Chickens'),
        actions: [
          Container(
            margin: EdgeInsets.only(
              right: size.width * 0.03,
            ),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () async {
                _signout(context);
              },
              child: const Text(
                'Sign-out',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14.0,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(
          bottom: size.height * 0.005,
          left: size.width * 0.1,
        ),
        child: const MovieInput(
          type: MovieInputType.add,
        ),
      ),
      body: BlocProvider(
        create: (context) => MovieCubit()..fetchData(),
        child: const HomePageStatus(),
      ),
    );
  }

  void _signout(BuildContext context) async {
    await context.read<AuthCubit>().signout();
    Navigator.pushReplacementNamed(context, '/Login');
  }
}

class HomePageStatus extends StatelessWidget {
  const HomePageStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select(
      (MovieCubit cubit) => cubit.state.status,
    );
    switch (status) {
      case MovieStatus.initial:
        return Container();
      case MovieStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case MovieStatus.success:
        return const HomePageContent();
      case MovieStatus.failed:
        return const HomePageContent();
    }
  }
}
