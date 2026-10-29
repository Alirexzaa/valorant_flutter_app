import '../../domain/entities/map.dart';

class MapModel extends ValorantMap {
  const MapModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.splashUrl,
    required super.tacticalMapUrl,
    required super.callouts,
  });

  factory MapModel.fromJson(Map<String, dynamic> json) {
    // استخراج لیست نقاط استراتژیک
    final List<String> calloutsList = (json['callouts'] as List<dynamic>? ?? [])
        .map((callout) => callout['regionName'] as String)
        .toList();

    return MapModel(
      id: json['uuid'] ?? '',
      name: json['displayName'] ?? 'Unknown Map',
      imageUrl: json['listViewIcon'] ?? '',
      splashUrl: json['splash'] ?? '',
      // ✅ استفاده از displayIcon برای عکس تاکتیکی (که پس‌زمینه شفاف داره)
      tacticalMapUrl: json['displayIcon'] ?? '',
      callouts: calloutsList,
    );
  }
}
