import 'dart:convert';

class AuthResponseModel {
  final bool? success;
  final String? message;
  final Data? data;

  AuthResponseModel({this.success, this.message, this.data});

  factory AuthResponseModel.fromJson(String str) =>
      AuthResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data?.toMap(),
  };
}

class Data {
  final bool? status;
  final String? message;
  final User? user;

  Data({this.status, this.message, this.user});

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    status: json["status"],
    message: json["message"],
    user: json["user"] == null ? null : User.fromMap(json["user"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "user": user?.toMap(),
  };
}

class User {
  final String? nama;
  final String? email;
  final String? uuid;
  final int? idUser;
  final String? token;

  User({this.nama, this.email, this.uuid, this.idUser, this.token});

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    nama: json["nama"],
    email: json["email"],
    uuid: json["uuid"],
    idUser: json["id_user"],
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "nama": nama,
    "email": email,
    "uuid": uuid,
    "id_user": idUser,
    "token": token,
  };
}
