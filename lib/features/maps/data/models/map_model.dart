import 'package:new_block/features/maps/domain/entities/map.dart';

class MapModel extends ValorantMap {
  const MapModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.splashUrl,
    required super.tacticalMapUrl,
    required super.coordinates,
    required super.callouts,
  });

  factory MapModel.fromJson(Map<String, dynamic> json) {
    final List<MapCallout> calloutsList =
        (json['callouts'] as List<dynamic>? ?? [])
            .map((callout) => MapCallout(name: callout['regionName'] ?? ''))
            .toList();

    return MapModel(
      id: json['uuid'] ?? '',
      name: json['displayName'] ?? 'Unknown Map',
      imageUrl: json['listViewIcon'] ?? '',
      splashUrl: json['splash'] ?? '',
      tacticalMapUrl: json['displayIcon'] ?? '',
      // ✅ گرفتن مختصات از API
      coordinates: json['coordinates'] ?? 'نامشخص',
      callouts: calloutsList,
    );
  }
}
