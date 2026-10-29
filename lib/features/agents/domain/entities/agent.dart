class Agent {
  final String id;
  final String name;
  final String role;
  final String imageUrl;
  final String description;
  final String fullPortrait;
  final String backgroundImage;
  final List<String> backgroundColors;
  final List<Ability> abilities;

  const Agent({
    required this.id,
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.description,
    required this.fullPortrait,
    required this.backgroundImage,
    required this.backgroundColors,
    required this.abilities,
  });
}

class Ability {
  final String name;
  final String description;
  final String iconUrl;

  const Ability({
    required this.name,
    required this.description,
    required this.iconUrl,
  });
}
