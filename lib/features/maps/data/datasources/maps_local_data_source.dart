import 'package:new_block/features/maps/data/models/map_model.dart';

abstract class MapsLocalDataSource {
  Future<List<MapModel>> getLastMaps();
  Future<void> cacheMaps(List<MapModel> mapsToCache);
}
