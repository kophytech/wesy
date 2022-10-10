// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionRoute _$RegionRouteFromJson(Map<String, dynamic> json) => RegionRoute(
      id: json['_id'] as String?,
      routeType: json['routeType'] as String?,
      name: json['name'] as String?,
      pins: (json['pins'] as List<dynamic>?)
          ?.map((e) => Pin.fromJson(e as Map<String, dynamic>))
          .toList(),
      company: json['company'] as String?,
    );

Map<String, dynamic> _$RegionRouteToJson(RegionRoute instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'routeType': instance.routeType,
      'name': instance.name,
      'pins': instance.pins,
      'company': instance.company,
    };
