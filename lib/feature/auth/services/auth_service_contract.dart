import '../models/user.dart';

abstract class IAuthService {
  Future<String> signin(UserModel user);
  Future<void> signout();
}
