// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  int? id;
  String? email;
  String? tokenType;
  String? accessToken;

  AuthModel({
    this.id,
    this.email,
    this.tokenType,
    this.accessToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        id: json["id"],
        email: json["email"],
        tokenType: json["token_type"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "token_type": tokenType,
        "access_token": accessToken,
      };
}
