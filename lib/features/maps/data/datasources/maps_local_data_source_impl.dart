import 'dart:convert';

import 'package:new_block/features/maps/data/datasources/maps_local_data_source.dart';
import 'package:new_block/features/maps/data/models/map_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapsLocalDataSourceImpl implements MapsLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const cachedMapsKey = 'CACHED_MAPS';

  MapsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<MapModel>> getLastMaps() async {
    final jsonString = sharedPreferences.getString(cachedMapsKey);
    if (jsonString != null) {
      final List decodedJson = json.decode(jsonString);
      return decodedJson.map((json) => MapModel.fromJson(json)).toList();
    } else {
      throw Exception('No cached data');
    }
  }

  @override
  Future<void> cacheMaps(List<MapModel> mapsToCache) async {
    final jsonString = json.encode(
      mapsToCache
          .map(
            (map) => {
              'uuid': map.id,
              'displayName': map.name,
              'displayIcon': map.imageUrl,
            },
          )
          .toList(),
    );
    await sharedPreferences.setString(cachedMapsKey, jsonString);
  }
}
