class Weapon {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final List<WeaponSkin> skins;
  final WeaponStats? stats; // ✅ اضافه شد

  const Weapon({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.skins,
    this.stats,
  });
}

class WeaponSkin {
  final String name;
  final String displayIcon;
  final String? videoUrl;

  const WeaponSkin({
    required this.name,
    required this.displayIcon,
    this.videoUrl,
  });
}

// ✅ کلاس آمار سلاح
class WeaponStats {
  final double fireRate;
  final int magazineSize;
  final double reloadTimeSeconds;
  final double equipTimeSeconds;
  final double runSpeedMultiplier;

  const WeaponStats({
    required this.fireRate,
    required this.magazineSize,
    required this.reloadTimeSeconds,
    required this.equipTimeSeconds,
    required this.runSpeedMultiplier,
  });
}
