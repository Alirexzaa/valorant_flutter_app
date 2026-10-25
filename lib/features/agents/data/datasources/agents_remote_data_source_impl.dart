import 'package:new_block/core/network/dio_client.dart';
import 'package:new_block/features/agents/data/models/agent_model.dart';
import 'package:new_block/features/agents/data/datasources/agents_remote_data_source.dart';

class AgentsRemoteDataSourceImpl implements AgentsRemoteDataSource {
  final DioClient dioClient;

  AgentsRemoteDataSourceImpl({required this.dioClient}); // ← تغییر کرد

  @override
  Future<List<AgentModel>> getAgents() async {
    // استفاده از Dio به جای http
    final response = await dioClient.dio.get(
      '/agents',
      queryParameters: {'isPlayableCharacter': true}, // پارامترهای URL
    );

    if (response.statusCode == 200) {
      final data = response.data; // توی Dio دیگه نیازی به json.decode نیست
      final List results = data['data'];

      return results.map((json) => AgentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load agents');
    }
  }
}
