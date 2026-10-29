import 'package:new_block/features/agents/domain/entities/agent.dart';

class AgentModel extends Agent {
  const AgentModel({
    required super.id,
    required super.name,
    required super.role,
    required super.imageUrl,
    required super.description,
    required super.fullPortrait,
    required super.backgroundImage, // ✅ این خط جا افتاده بود
    required super.backgroundColors,
    required super.abilities,
  });
  factory AgentModel.fromJson(Map<String, dynamic> json) {
    // تابعی برای پاک کردن تگ‌های HTML (مثل <whitebold>)
    String cleanHtml(String? text) {
      if (text == null) return '';
      // این Regex هر چیزی که بین < و > هست رو پیدا میکنه و پاکش میکنه
      return text.replaceAll(RegExp(r'<[^>]*>'), '');
    }

    // تبدیل لیست توانایی‌ها
    final List<Ability> abilitiesList =
        (json['abilities'] as List<dynamic>? ?? [])
            .map(
              (ability) => Ability(
                name: ability['displayName'] ?? 'Unknown',
                // ✅ اینجا تگ‌ها رو پاک میکنیم
                description: cleanHtml(ability['description']),
                iconUrl: ability['displayIcon'] ?? '',
              ),
            )
            .toList();

    // تبدیل لیست رنگ‌ها
    final List<String> colors =
        (json['backgroundGradientColors'] as List<dynamic>? ??
                ['#ff4655', '#0f1923'])
            .map((color) => '#${color.toString().substring(0, 6)}')
            .toList();

    return AgentModel(
      id: json['uuid'] ?? '',
      name: json['displayName'] ?? 'Unknown',
      role: json['role'] != null ? json['role']['displayName'] : 'No Role',
      imageUrl: json['displayIcon'] ?? '',
      description: cleanHtml(json['description']),
      fullPortrait: json['fullPortrait'] ?? json['displayIcon'] ?? '',
      // ✅ استخراج عکس پس‌زمینه
      backgroundImage: json['background'] ?? '',
      backgroundColors: colors,
      abilities: abilitiesList,
    );
  }
}
