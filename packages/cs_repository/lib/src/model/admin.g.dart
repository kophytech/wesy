// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Admin _$AdminFromJson(Map<String, dynamic> json) => Admin(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      region: json['region'] == null
          ? null
          : Region.fromJson(json['region'] as Map<String, dynamic>),
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AdminToJson(Admin instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'region': instance.region,
      'roles': instance.roles,
    };
