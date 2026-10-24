import 'package:new_block/features/maps/domain/entities/map.dart';

class MapModel extends ValorantMap {
  const MapModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory MapModel.fromJson(Map<String, dynamic> json) {
    return MapModel(
      id: json['uuid'] ?? '',
      name: json['displayName'] ?? 'Unknown Map',
      imageUrl: json['displayIcon'] ?? '',
    );
  }
}
