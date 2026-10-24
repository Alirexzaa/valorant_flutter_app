import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:new_block/features/agents/data/models/agent_model.dart';
import 'package:new_block/features/agents/data/datasources/agents_remote_data_source.dart';

class AgentsRemoteDataSourceImpl implements AgentsRemoteDataSource {
  final http.Client client;

  AgentsRemoteDataSourceImpl(this.client);

  @override
  Future<List<AgentModel>> getAgents() async {
    // آدرس API والورانت
    final response = await client.get(
      Uri.parse('https://valorant-api.com/v1/agents?isPlayableCharacter=true'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['data'];

      return results.map((json) => AgentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load agents');
    }
  }
}
