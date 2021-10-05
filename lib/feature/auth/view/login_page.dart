import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rotten_chickens/Core/const/global.dart';
import 'package:rotten_chickens/feature/auth/cubit/auth_cubit.dart';
import 'package:rotten_chickens/feature/auth/view/login_button.dart';
import 'package:rotten_chickens/feature/auth/view/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormState> _passwordKey = GlobalKey();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    _transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (prevstate, state) {
        return prevstate.status != state.status;
      },
      listener: (context, state) {
        var submitStatus = state.status;
        if (submitStatus == AuthStatus.failed) {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
            msg: 'kombinasi password dan email salah',
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
          );
        }
        if (submitStatus == AuthStatus.loading) {
          showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }
        if (submitStatus == AuthStatus.success) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/Home',
            (Route<dynamic> route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Global.darkGrey,
                      Global.mediumBlue,
                    ],
                  ),
                ),
                child: Opacity(
                  opacity: _opacity.value,
                  child: Transform.scale(
                    scale: _transform.value,
                    child: Container(
                      width: size.width * .9,
                      height: size.width * 1.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            blurRadius: 90,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(.7),
                            ),
                          ),
                          LoginForm(
                            formKey: _formKey,
                            passwordKey: _passwordKey,
                          ),
                          const LoginButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
