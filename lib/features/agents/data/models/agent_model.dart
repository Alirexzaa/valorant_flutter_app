import 'package:new_block/features/agents/domain/entities/agent.dart';

class AgentModel extends Agent {
  const AgentModel({
    required super.id,
    required super.name,
    required super.role,
    required super.imageUrl,
  });

  // این متد JSON دریافتی از API رو تبدیل به کلاس میکنه
  factory AgentModel.fromJson(Map<String, dynamic> json) {
    return AgentModel(
      id: json['uuid'] ?? '',
      name: json['displayName'] ?? 'Unknown',
      role: json['role'] != null ? json['role']['displayName'] : 'No Role',
      imageUrl: json['displayIcon'] ?? '',
    );
  }
}
