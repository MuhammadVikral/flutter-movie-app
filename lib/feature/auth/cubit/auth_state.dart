part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, success, failed, error }

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required String email,
    required String password,
    required AuthStatus status,
    required bool isVisible,
    required bool showErrorMessage,
  }) = _AuthState;

  factory AuthState.initial() => const AuthState(
        status: AuthStatus.initial,
        email: '',
        password: '',
        isVisible: false,
        showErrorMessage: false,
      );
  const AuthState._();
  bool get isEmailValid {
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    var regExp = RegExp(pattern);
    if (regExp.hasMatch(email)) {
      return true;
    }
    return false;
  }

  bool get isPasswordValid {
    if (password == '') {
      return false;
    }
    return true;
  }
}
