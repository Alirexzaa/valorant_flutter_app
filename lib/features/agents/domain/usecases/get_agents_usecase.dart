import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/agents/domain/entities/agent.dart';
import 'package:new_block/features/agents/domain/repositories/agents_repository.dart';

class GetAgentsUseCase {
  final AgentsRepository repository;

  GetAgentsUseCase(this.repository);

  Future<Either<Failure, List<Agent>>> call() async {
    return await repository.getAgents();
  }
}
