// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteDetails _$RouteDetailsFromJson(Map<String, dynamic> json) => RouteDetails(
      id: json['_id'] as String?,
      routeType: json['routeType'] as String?,
      name: json['name'] as String?,
      createdBy: json['createdBy'] == null
          ? null
          : CreatedBy.fromJson(json['createdBy'] as Map<String, dynamic>),
      pins: (json['pins'] as List<dynamic>?)
          ?.map((e) => Pin.fromJson(e as Map<String, dynamic>))
          .toList(),
      workers: json['workers'] != null
          ? (json['workers'] as List<dynamic>?)
              ?.map((e) => Worker.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );

Map<String, dynamic> _$RouteDetailsToJson(RouteDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'routeType': instance.routeType,
      'name': instance.name,
      'createdBy': instance.createdBy!.toJson(),
      'pins': instance.pins!.map((e) => e.toJson()).toList(),
      'workers': instance.workers!.map((e) => e.toJson()).toList(),
    };

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) => CreatedBy(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CreatedByToJson(CreatedBy instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };
