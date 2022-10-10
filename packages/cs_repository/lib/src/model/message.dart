import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final bool? success;
  final String? message;
  final dynamic data;

  Message({this.success, this.message, this.data});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
