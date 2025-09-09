import 'package:shared_preferences/shared_preferences.dart';

import '../../model/response_model/auth_response_model.dart';

class AuthLocalDatasources {
  Future<void> saveAuthData(AuthResponseModel authResponseModel) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('auth_data', authResponseModel.toJson());
  }

  Future<void> removeAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('auth_data');
  }

  Future<AuthResponseModel> getAuthData() async {
    final pref = await SharedPreferences.getInstance();
    final authData = pref.getString('auth_data');
    if (authData != null) {
      return AuthResponseModel.fromJson(authData);
    } else {
      throw Exception('No auth data found');
    }
  }

  Future<bool> isAuth() async {
    final pref = await SharedPreferences.getInstance();
    final authData = pref.getString('auth_data');
    return authData != null;
  }
}
