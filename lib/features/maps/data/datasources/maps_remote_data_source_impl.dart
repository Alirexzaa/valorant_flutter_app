import 'package:new_block/core/network/dio_client.dart';

import 'package:new_block/features/maps/data/datasources/maps_remote_data_source.dart';
import 'package:new_block/features/maps/data/models/map_model.dart';

class MapsRemoteDataSourceImpl implements MapsRemoteDataSource {
  final DioClient dioClient;

  MapsRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<MapModel>> getMaps() async {
    // آدرس API والورانت
    final response = await dioClient.dio.get('/maps');

    if (response.statusCode == 200) {
      final data = response.data; // ← نیازی به json.decode(response.body) نیست
      final List results = data['data'];

      return results.map((json) => MapModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load maps');
    }
  }
}
