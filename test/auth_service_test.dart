import 'package:flutter_test/flutter_test.dart';
import 'package:rotten_chickens/feature/auth/models/user.dart';
import 'package:rotten_chickens/feature/auth/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  late AuthService service = AuthService();
  tearDown(() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('user');
  });
  group(
    'authentication',
    () {
      UserModel user = const UserModel(
        email: 'holywings@test.com',
        password: 'Test123456',
      );
      test(
        'should failed when email & password is wrong',
        () async {
          expect(await service.signin(user), "failed");
        },
      );

      test(
        'should success when email & password is correct',
        () async {
          UserModel user = const UserModel(
            email: 'holywings@test.com',
            password: 'Test12345',
          );
          expect(await service.signin(user), "success");
        },
      );

      test(
        'should store in chace when success',
        () async {
          UserModel user = const UserModel(
            email: 'holywings@test.com',
            password: 'Test12345',
          );
          expect(await service.signin(user), "success");
          var pref = await SharedPreferences.getInstance();
          var userStored = pref.getString('user');
          expect(userStored != null, true);
        },
      );

      test(
        'should delete user & movies from chace when logout',
        () async {
          await service.signout();
          var pref = await SharedPreferences.getInstance();
          var userStored = pref.getString('user');
          expect(userStored == null, true);
        },
      );
    },
  );
}
