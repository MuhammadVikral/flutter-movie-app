import 'package:flutter/material.dart';
import 'package:rotten_chickens/Core/const/global.dart';
import 'package:rotten_chickens/feature/auth/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFromFieldComponent extends StatelessWidget {
  const TextFromFieldComponent({
    Key? key,
    required this.formKey,
    required this.hintText,
    required this.prefixIconData,
    required this.obscureText,
    required this.showErrorMessage,
    required this.onChanged,
    required this.suffixIconData,
    required this.validator,
    this.controller,
  }) : super(key: key);

  final GlobalKey formKey;
  final String hintText;
  final IconData prefixIconData;
  final IconData? suffixIconData;
  final bool obscureText;
  final bool showErrorMessage;

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formKey,
      controller: controller,
      onChanged: onChanged,
      autofocus: false,
      obscureText: obscureText,
      cursorColor: Global.mediumBlue,
      autovalidateMode: showErrorMessage
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      validator: validator,
      style: const TextStyle(
        color: Global.mediumBlue,
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Global.mediumBlue),
        focusColor: Global.mediumBlue,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Global.mediumBlue),
        ),
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Global.mediumBlue,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            context.read<AuthCubit>().changeVisibility();
          },
          child: Icon(
            suffixIconData,
            size: 18,
            color: Global.mediumBlue,
          ),
        ),
      ),
    );
  }
}
