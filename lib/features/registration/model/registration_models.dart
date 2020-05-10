class LoginModel {
  String token;
  String refreshToken;

  LoginModel({this.token, this.refreshToken});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        token: json['token'], refreshToken: json['refresh_token']);
  }
}

class RegisterModel {

  String lastLoginAt;

  String signupAt;

  bool emailVerified;

  bool forceLogin;

  String id;

  String email;

  String password;

  String displayName;

  String appId;

  int version;


  RegisterModel({this.lastLoginAt, this.signupAt, this.emailVerified,
      this.forceLogin, this.id, this.email, this.password, this.displayName,
      this.appId, this.version});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
        lastLoginAt: json['last_login_at'],
        signupAt: json['signup_at'],
        emailVerified: json['email_verified'],
        forceLogin: json['force_login'],
        id: json['_id'],
        email: json['email'],
        password: json['password'],
        displayName: json['display_name'],
        appId: json['app_id'],
        version: json['__v'],

    );
  }
}
