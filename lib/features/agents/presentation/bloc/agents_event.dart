abstract class AgentsEvent {
  const AgentsEvent();
}

class FetchAgentsEvent extends AgentsEvent {
  const FetchAgentsEvent();
}

// ✅ این کلاس رو جا انداخته بودیم! حالا اضافه شد:
class SearchAgentsEvent extends AgentsEvent {
  final String query;
  const SearchAgentsEvent(this.query);
}
