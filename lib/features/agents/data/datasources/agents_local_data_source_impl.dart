import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:new_block/features/agents/data/models/agent_model.dart';
import 'package:new_block/features/agents/data/datasources/agents_local_data_source.dart';

class AgentsLocalDataSourceImpl implements AgentsLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const cachedAgentsKey = 'CACHED_AGENTS';

  AgentsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<AgentModel>> getLastAgents() async {
    final jsonString = sharedPreferences.getString(cachedAgentsKey);
    if (jsonString != null) {
      final List decodedJson = json.decode(jsonString);
      return decodedJson.map((json) => AgentModel.fromJson(json)).toList();
    } else {
      throw Exception('No cached data');
    }
  }

  @override
  Future<void> cacheAgents(List<AgentModel> agentsToCache) async {
    final jsonString = json.encode(
      agentsToCache
          .map(
            (agent) => {
              'uuid': agent.id,
              'displayName': agent.name,
              'role': {'displayName': agent.role},
              'displayIcon': agent.imageUrl,
            },
          )
          .toList(),
    );
    await sharedPreferences.setString(cachedAgentsKey, jsonString);
  }
}
