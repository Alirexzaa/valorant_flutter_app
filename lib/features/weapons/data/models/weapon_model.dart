import 'package:new_block/features/weapons/domain/entities/weapon.dart';

class WeaponModel extends Weapon {
  const WeaponModel({
    required super.id,
    required super.name,
    required super.category,
    required super.imageUrl,
    required super.skins,
    super.stats,
  });

  factory WeaponModel.fromJson(Map<String, dynamic> json) {
    final List<WeaponSkin> skinsList = (json['skins'] as List<dynamic>? ?? [])
        .map((skinJson) {
          String? videoUrl;
          if (skinJson['chromas'] != null &&
              (skinJson['chromas'] as List).isNotEmpty) {
            videoUrl = skinJson['chromas'][0]['streamedVideo'];
          }
          if (videoUrl == null &&
              skinJson['levels'] != null &&
              (skinJson['levels'] as List).isNotEmpty) {
            videoUrl = skinJson['levels'][0]['streamedVideo'];
          }
          return WeaponSkin(
            name: skinJson['displayName'] ?? 'Unknown Skin',
            displayIcon: skinJson['displayIcon'] ?? '',
            videoUrl: videoUrl,
          );
        })
        .toList();

    WeaponStats? stats;
    if (json['weaponStats'] != null) {
      stats = WeaponStats(
        fireRate: (json['weaponStats']['fireRate'] ?? 0.0).toDouble(),
        magazineSize: json['weaponStats']['magazineSize'] ?? 0,
        reloadTimeSeconds: (json['weaponStats']['reloadTimeSeconds'] ?? 0.0)
            .toDouble(),
        equipTimeSeconds: (json['weaponStats']['equipTimeSeconds'] ?? 0.0)
            .toDouble(),
        runSpeedMultiplier: (json['weaponStats']['runSpeedMultiplier'] ?? 0.0)
            .toDouble(),
      );
    }

    return WeaponModel(
      id: json['uuid'] ?? '',
      name: json['displayName'] ?? 'Unknown Weapon',
      // ✅ پاک کردن متن اضافی EEquippableCategory:: از دسته‌بندی
      category: (json['category'] ?? 'Unknown').replaceAll(
        'EEquippableCategory::',
        '',
      ),
      imageUrl: json['displayIcon'] ?? '',
      skins: skinsList,
      stats: stats,
    );
  }
}
