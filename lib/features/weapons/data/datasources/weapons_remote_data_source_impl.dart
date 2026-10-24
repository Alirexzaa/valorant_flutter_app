import 'package:dio/dio.dart';

import 'package:new_block/core/network/dio_client.dart';
import 'package:new_block/features/weapons/data/models/weapon_model.dart';
import 'package:new_block/features/weapons/data/datasources/weapons_remote_data_source.dart';

class WeaponsRemoteDataSourceImpl implements WeaponsRemoteDataSource {
  final DioClient dioClient;

  WeaponsRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<WeaponModel>> getWeapons() async {
    try {
      // جادوی Dio: دیگه لازم نیست URL کامل بنویسیم (baseUrl رو توی DioClient تنظیم کردیم)
      final response = await dioClient.dio.get('/weapons');

      final List results = response.data['data'];
      return results.map((json) => WeaponModel.fromJson(json)).toList();
    } on DioException catch (e) {
      // مدیریت خطای اختصاصی Dio
      throw Exception(e.message ?? 'Failed to load weapons');
    }
  }
}
