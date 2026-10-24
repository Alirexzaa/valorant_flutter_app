import 'package:new_block/features/agents/data/models/agent_model.dart';

abstract class AgentsRemoteDataSource {
  Future<List<AgentModel>> getAgents();
}
