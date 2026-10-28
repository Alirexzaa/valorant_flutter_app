import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_block/features/agents/domain/entities/agent.dart';
import 'package:new_block/features/agents/domain/usecases/get_agents_usecase.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_event.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_state.dart';
import 'package:new_block/features/agents/domain/usecases/toggle_favorite_usecase.dart';
import 'package:new_block/features/agents/domain/usecases/get_favorite_ids_usecase.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<T> debounceTime<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class AgentsBloc extends Bloc<AgentsEvent, AgentsState> {
  final GetAgentsUseCase getAgentsUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final GetFavoriteIdsUseCase getFavoriteIdsUseCase;

  List<Agent> _allAgents = [];

  AgentsBloc({
    required this.getAgentsUseCase,
    required this.toggleFavoriteUseCase,
    required this.getFavoriteIdsUseCase,
  }) : super(const AgentsState.initial()) {
    on<FetchAgentsEvent>(_onFetchAgents, transformer: droppable());

    on<SearchAgentsEvent>(
      _onSearchAgents,
      transformer: debounceTime(const Duration(milliseconds: 500)),
    );

    on<ToggleFavoriteEvent>((event, emit) async {
      final toggleResult = await toggleFavoriteUseCase(
        event.agentId,
        event.isFavorite,
      );

      toggleResult.fold((failure) => emit(AgentsState.error(failure.message)), (
        _,
      ) {
        if (state is AgentsSuccess) {
          final currentState = state as AgentsSuccess;
          final newFavorites = List<String>.from(currentState.favoriteIds);

          if (event.isFavorite) {
            if (!newFavorites.contains(event.agentId)) {
              newFavorites.add(event.agentId);
            }
          } else {
            newFavorites.remove(event.agentId);
          }

          // ✅ اینجا یه لیست جدید میسازیم تا Freezed مجبور بشه تغییر رو قبول کنه
          final newAgents = List<Agent>.from(currentState.agents);

          emit(AgentsState.success(newAgents, newFavorites));
        }
      });
    });
  }

  Future<void> _onFetchAgents(
    FetchAgentsEvent event,
    Emitter<AgentsState> emit,
  ) async {
    emit(const AgentsState.loading());
    final result = await getAgentsUseCase();
    final favoritesResult = await getFavoriteIdsUseCase();

    result.fold((failure) => emit(AgentsState.error(failure.message)), (
      agents,
    ) {
      _allAgents = agents;
      favoritesResult.fold(
        (l) => emit(AgentsState.success(agents, [])),
        (favoriteIds) => emit(AgentsState.success(agents, favoriteIds)),
      );
    });
  }

  void _onSearchAgents(SearchAgentsEvent event, Emitter<AgentsState> emit) {
    if (_allAgents.isEmpty) return;

    final query = event.query.toLowerCase().trim();

    // گرفتن لیست فعلی علاقه‌مندی‌ها از State
    List<String> currentFavorites = [];
    if (state is AgentsSuccess) {
      currentFavorites = (state as AgentsSuccess).favoriteIds;
    }

    if (query.isEmpty) {
      emit(AgentsState.success(_allAgents, currentFavorites));
    } else {
      final filteredAgents = _allAgents
          .where((agent) => agent.name.toLowerCase().contains(query))
          .toList();
      emit(AgentsState.success(filteredAgents, currentFavorites));
    }
  }
}
