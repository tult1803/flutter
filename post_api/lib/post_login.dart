
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


//  Nạp và phân tích cú pháp dữ liệu JSON
Future<Post> getPost(String url, String firebase_token) async{
  Map<String, String> headers = {"Content-type": "application/json"};
  String json = '{"grant_type":"firebase_token","firebase_token":"$firebase_token"}';
  final response = await http.post(
      url, headers: headers,
      body: json);
     return postFromJson(response.body);
}

Future<http.Response> createPost(Post post, String url) async{
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
      body: postToJson(post)
  );
  return response;
}

Post postFromJson(String str) {
  final jsonData = json.decode(str);
  return Post.fromJson(jsonData);
}

String postToJson(Post data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Post {
  String userID;
  String access_token;
  String refresh_token;
  String role;

  Post({
    this.userID,
    this.access_token,
    this.refresh_token,
    this.role
  });

  factory Post.fromJson(Map<String, dynamic> json) => new Post(
    userID: json["userID"],
    access_token: json["description"],
    refresh_token: json["refresh_token"],
      role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "userID": userID,
    "access_token": access_token,
    "refresh_token": refresh_token,
    "role": role,
  };
}

