import 'package:rotten_chickens/feature/auth/services/auth_service.dart';
import 'package:rotten_chickens/feature/home_screen/services/movie_service_implementation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService implements IAuthService {
  AuthService();
  final UserModel registeredUser = const UserModel(
    email: 'holywings@test.com',
    password: 'Test12345',
  );
  @override
  Future<String> signin(UserModel user) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    try {
      if (user == registeredUser) {
        _saveToChace(user);
        return 'success';
      } else {
        return 'failed';
      }
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<void> signout() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('user');
    pref.remove('movies');
    await MovieService(pref).initMovie();
  }

  Future<String> isSignin() async {
    var pref = await SharedPreferences.getInstance();
    var user = pref.getString('user');

    return user.toString();
  }

  void _saveToChace(UserModel user) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('user', user.toString());
  }
}
