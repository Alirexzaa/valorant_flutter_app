class Weapon {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final List<WeaponSkin> skins; // ✅ اضافه شد

  const Weapon({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.skins,
  });
}

class WeaponSkin {
  final String name;
  final String displayIcon;
  final String? videoUrl; // ✅ لینک ویدیو

  const WeaponSkin({
    required this.name,
    required this.displayIcon,
    this.videoUrl,
  });
}
