import 'package:dio/dio.dart';
import 'package:new_block/core/network/dio_client.dart';
import 'package:new_block/features/maps/data/models/map_model.dart';
import 'package:new_block/features/maps/data/datasources/maps_remote_data_source.dart';
import 'package:new_block/core/errors/failures.dart';

// ✅ ایمپورت‌های مربوط به زبان
import 'package:new_block/core/injection_container.dart';
import 'package:new_block/core/language_cubit.dart';

class MapsRemoteDataSourceImpl implements MapsRemoteDataSource {
  final DioClient dioClient;

  MapsRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<MapModel>> getMaps() async {
    try {
      // ✅ گرفتن زبان فعلی
      final currentLanguage = sl<LanguageCubit>().state;

      final response = await dioClient.dio.get(
        '/maps',
        queryParameters: {
          'language': currentLanguage, // ✅ ارسال زبان به API
        },
      );

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
