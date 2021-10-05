import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String email;
  final String password;
  const UserModel({
    required this.email,
    required this.password,
  });
  tojson() => {
        'email': email,
        'password': password,
      };

  @override
  List<Object?> get props => [email, password];
}
