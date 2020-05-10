
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:testockmbl/base/network_provider.dart';
import 'package:testockmbl/features/registration/model/registration_models.dart';

class RegistrationRepository {
  ApiProvider _provider = ApiProvider();

  Future<LoginModel> login(String email,String password) async {

    var requestBody = {};
    requestBody["email"] = email;
    requestBody["password"] = password;
    String requestJson = json.encode(requestBody);

    final response = await _provider.post("login",requestJson);
    return LoginModel.fromJson(response);

  }

  Future<RegisterModel> register(String email,String password, String username) async {
    var requestBody = {};
    requestBody["email"] = email;
    requestBody["password"] = password;
    requestBody["display_name"] = username;
    String requestJson = json.encode(requestBody);

    final response = await _provider.post("register",requestJson);
    return RegisterModel.fromJson(response);
  }

  Future<bool> saveLoginInfo(LoginModel loginModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('prefToken', loginModel.token);
    await prefs.setString('prefRefreshToken', loginModel.refreshToken);
    await prefs.setBool('prefIsUserLoggedIn', true);
    return true;
  }

  void saveRegisterInfo(RegisterModel registerModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
//    await prefs.setString('prefLastLoginAt', registerModel.);
//    await prefs.setString('prefRefreshToken', registerModel.refreshToken);

  }

}