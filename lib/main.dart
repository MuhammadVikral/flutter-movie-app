import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotten_chickens/Core/navigator/app_router.dart';
import 'package:rotten_chickens/feature/auth/cubit/auth_cubit.dart';
import 'package:rotten_chickens/feature/auth/view/login_page.dart';
import 'package:rotten_chickens/feature/home_screen/cubit/movie_cubit.dart';
import 'package:rotten_chickens/feature/home_screen/view/home_page.dart';

import 'feature/auth/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.top,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            AuthService(),
          ),
        ),
        BlocProvider(
          create: (context) => MovieCubit()..init(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rotten Chicken',
        onGenerateRoute: _appRouter.onGeneratedRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: AuthService().isSignin(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return snapshot.data != 'null'
                ? const HomePage()
                : const LoginPage();
          },
        ),
      ),
    );
  }
}
