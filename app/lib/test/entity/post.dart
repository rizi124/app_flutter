import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Api {
  int id;
  String title;
  Api(this.id, this.title);

  factory Api.fromJson(Map<String, dynamic> json) => _$ApiFromJson(json);
  Map<String, dynamic> toJson() => _$ApiToJson(this);
  
}
