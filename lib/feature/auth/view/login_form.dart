import 'package:flutter/material.dart';
import 'package:rotten_chickens/Core/widget/text_form_field_component.dart';
import 'package:rotten_chickens/feature/auth/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required GlobalKey<FormState> passwordKey,
  })  : _formKey = formKey,
        _passwordKey = passwordKey,
        super(key: key);
  final GlobalKey<FormState> _formKey;
  final GlobalKey<FormState> _passwordKey;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _emailInput(context, state),
              _separator(size.height),
              _passwordInput(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _emailInput(BuildContext context, AuthState state) {
    return TextFromFieldComponent(
      formKey: _formKey,
      hintText: 'email',
      prefixIconData: Icons.email_outlined,
      obscureText: false,
      showErrorMessage: state.showErrorMessage,
      suffixIconData: state.isEmailValid ? Icons.check : null,
      onChanged: (value) {
        debugPrint(value);
        context.read<AuthCubit>().emailChanged(value);
      },
      validator: (value) {
        return state.status == AuthStatus.initial
            ? null
            : !state.isEmailValid
                ? 'Masukkan Format email yang tepat'
                : state.status == AuthStatus.failed
                    ? ''
                    : null;
      },
    );
  }

  Widget _passwordInput(BuildContext context, AuthState state) {
    return TextFromFieldComponent(
      formKey: _passwordKey,
      hintText: 'password',
      prefixIconData: Icons.lock_clock_outlined,
      obscureText: state.isVisible ? false : true,
      showErrorMessage: state.showErrorMessage,
      suffixIconData: state.isVisible ? Icons.visibility_off : Icons.visibility,
      onChanged: (value) {
        debugPrint(value);
        context.read<AuthCubit>().passwordChanged(value);
      },
      validator: (value) {
        return state.status == AuthStatus.initial
            ? null
            : !state.isPasswordValid
                ? 'Harap Masukkan Password'
                : state.status == AuthStatus.failed
                    ? ''
                    : null;
      },
    );
  }

  SizedBox _separator(double size) {
    return SizedBox(
      height: size * 0.04,
    );
  }
}
