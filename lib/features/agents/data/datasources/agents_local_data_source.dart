import 'package:new_block/features/agents/data/models/agent_model.dart';

abstract class AgentsLocalDataSource {
  Future<List<AgentModel>> getLastAgents();
  Future<void> cacheAgents(List<AgentModel> agentsToCache);
}
