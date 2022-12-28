// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? profileImage;
  String? token;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'token': token,
    };
  }

  factory ProfileModel.fromMap(Map map) {
    return ProfileModel(
      id: map['user']['id'],
      name: map['user']['name'],
      email: map['user']['email'],
      profileImage: map['user']['profileImage'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map);

  factory ProfileModel.fromSharedPrefs(String? jsonData) {
    var parse = jsonDecode(jsonData!);
    Map map = jsonDecode(parse);
    print(map.runtimeType);
    return ProfileModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profileImage: map['profileImage'],
      token: map['token'],
    );
  }
}
