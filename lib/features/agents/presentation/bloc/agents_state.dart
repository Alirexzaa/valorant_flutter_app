import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:new_block/features/agents/domain/entities/agent.dart';

part 'agents_state.freezed.dart';

@freezed
sealed class AgentsState with _$AgentsState {
  const factory AgentsState.initial() = AgentsInitial; // ← بدون آندرلاین
  const factory AgentsState.loading() = AgentsLoading;
  const factory AgentsState.success(List<Agent> agents) = AgentsSuccess;
  const factory AgentsState.error(String message) = AgentsError;
}
