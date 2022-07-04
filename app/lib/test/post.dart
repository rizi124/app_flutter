// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';

Post postsFromJson(String str) => Post.fromJson(json.decode(str));

String postsToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.success,
    required this.topics,
  });

  bool success;
  List<Topic> topics;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        success: json["success"],
        topics: List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "topics": List<dynamic>.from(topics.map((x) => x.toJson())),
      };
}

class Topic {
  Topic({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
