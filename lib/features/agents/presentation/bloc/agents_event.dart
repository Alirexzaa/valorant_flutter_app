abstract class AgentsEvent {
  const AgentsEvent();
}

class FetchAgentsEvent extends AgentsEvent {
  const FetchAgentsEvent();
}

class SearchAgentsEvent extends AgentsEvent {
  final String query;
  const SearchAgentsEvent(this.query);
}

class ToggleFavoriteEvent extends AgentsEvent {
  final String agentId;
  final bool isFavorite;
  const ToggleFavoriteEvent(this.agentId, this.isFavorite);
}
