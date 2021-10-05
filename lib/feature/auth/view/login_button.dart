import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotten_chickens/feature/auth/cubit/auth_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buttonComponent(
          context: context,
          title: 'LOGIN',
          size: size,
          voidCallback: () {
            context.read<AuthCubit>().signin();
          },
        ),
        SizedBox(width: size.width / 25),
      ],
    );
  }

  InkWell _buttonComponent({
    required BuildContext context,
    required String title,
    required Size size,
    required final VoidCallback voidCallback,
  }) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: voidCallback,
      child: Container(
        height: size.width / 8,
        width: size.width / 2.6,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff4796ff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
