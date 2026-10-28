import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:new_block/features/agents/domain/entities/agent.dart';

part 'agents_state.freezed.dart';

@freezed
sealed class AgentsState with _$AgentsState {
  const factory AgentsState.initial() = AgentsInitial;
  const factory AgentsState.loading() = AgentsLoading;
  const factory AgentsState.success(
    List<Agent> agents,
    List<String> favoriteIds,
  ) = AgentsSuccess;
  const factory AgentsState.error(String message) = AgentsError;
}
