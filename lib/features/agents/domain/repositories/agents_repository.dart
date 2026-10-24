import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/agents/domain/entities/agent.dart';

abstract class AgentsRepository {
  Future<Either<Failure, List<Agent>>> getAgents();
}
