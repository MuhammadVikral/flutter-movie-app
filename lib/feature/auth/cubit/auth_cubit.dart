import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rotten_chickens/feature/auth/models/user.dart';
import 'package:rotten_chickens/feature/auth/services/auth_service.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService service;
  AuthCubit(
    this.service,
  ) : super(AuthState.initial());

  emailChanged(String _email) {
    emit(
      state.copyWith(
        email: _email,
        status: AuthStatus.initial,
      ),
    );
  }

  passwordChanged(String _password) {
    emit(
      state.copyWith(
        password: _password,
      ),
    );
  }

  changeVisibility() {
    emit(
      state.copyWith(
        isVisible: !state.isVisible,
      ),
    );
  }

  Future<void> signin() async {
    UserModel user = UserModel(
      email: state.email,
      password: state.password,
    );

    if (state.isEmailValid && state.isPasswordValid) {
      emit(
        state.copyWith(
          status: AuthStatus.loading,
          showErrorMessage: true,
        ),
      );
      var response = await service.signin(user);
      if (response == 'success') {
        emit(
          state.copyWith(
            status: AuthStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: AuthStatus.failed,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          showErrorMessage: true,
        ),
      );
    }
  }

  Future<void> signout() async {
    await service.signout();
    emit(AuthState.initial());
  }
}
