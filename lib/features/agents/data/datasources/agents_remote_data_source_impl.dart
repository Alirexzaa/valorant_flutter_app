import 'package:dio/dio.dart';
import 'package:new_block/core/network/dio_client.dart';
import 'package:new_block/features/agents/data/models/agent_model.dart';
import 'package:new_block/features/agents/data/datasources/agents_remote_data_source.dart';
import 'package:new_block/core/errors/failures.dart';

class AgentsRemoteDataSourceImpl implements AgentsRemoteDataSource {
  final DioClient dioClient;

  AgentsRemoteDataSourceImpl({required this.dioClient}); // ← تغییر کرد

  @override
  Future<List<AgentModel>> getAgents() async {
    try {
      final response = await dioClient.dio.get(
        '/agents',
        queryParameters: {'isPlayableCharacter': true},
      );

      final data = response.data;
      final List results = data['data'];
      return results.map((json) => AgentModel.fromJson(json)).toList();
    } on DioException catch (e) {
      // ⬇️ اینجا خطاهای Dio رو با پیام‌های دقیق‌تر پرتاب می‌کنیم
      if (e.error is Failure) {
        throw Exception((e.error as Failure).message);
      }
      throw Exception('Failed to load agents');
    }
  }
}
