import 'package:dio/dio.dart';
import 'package:new_block/core/network/dio_client.dart';
import 'package:new_block/features/agents/data/models/agent_model.dart';
import 'package:new_block/features/agents/data/datasources/agents_remote_data_source.dart';
import 'package:new_block/core/errors/failures.dart';

// ✅ این دو تا ایمپورت برای زبان جدید اضافه شدند
import 'package:new_block/core/injection_container.dart';
import 'package:new_block/core/language_cubit.dart';

class AgentsRemoteDataSourceImpl implements AgentsRemoteDataSource {
  final DioClient dioClient;

  AgentsRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<AgentModel>> getAgents() async {
    try {
      // ✅ گرفتن زبان فعلی از LanguageCubit
      final currentLanguage = sl<LanguageCubit>().state;

      final response = await dioClient.dio.get(
        '/agents',
        queryParameters: {
          'isPlayableCharacter': true,
          'language': currentLanguage, // ✅ ارسال زبان به API
        },
      );

      final data = response.data;
      final List results = data['data'];
      return results.map((json) => AgentModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error is Failure) {
        throw Exception((e.error as Failure).message);
      }
      throw Exception('Failed to load agents');
    }
  }
}
