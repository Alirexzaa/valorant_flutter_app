import 'package:dio/dio.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/core/network/dio_client.dart';
import 'package:new_block/features/maps/data/datasources/maps_remote_data_source.dart';
import 'package:new_block/features/maps/data/models/map_model.dart';

class MapsRemoteDataSourceImpl implements MapsRemoteDataSource {
  final DioClient dioClient;

  MapsRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<MapModel>> getMaps() async {
    try {
      final response = await dioClient.dio.get('/maps');

      final data = response.data;
      final List results = data['data'];
      return results.map((json) => MapModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error is Failure) {
        throw Exception((e.error as Failure).message);
      }
      throw Exception('Failed to load maps');
    }
  }
}
