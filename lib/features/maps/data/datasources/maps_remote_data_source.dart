import 'package:new_block/features/maps/data/models/map_model.dart';

abstract class MapsRemoteDataSource {
  Future<List<MapModel>> getMaps();
}
