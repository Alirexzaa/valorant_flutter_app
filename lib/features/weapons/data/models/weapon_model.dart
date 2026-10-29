import 'package:new_block/features/weapons/domain/entities/weapon.dart';

class WeaponModel extends Weapon {
  const WeaponModel({
    required super.id,
    required super.name,
    required super.category,
    required super.imageUrl,
    required super.skins,
  });

  factory WeaponModel.fromJson(Map<String, dynamic> json) {
    // استخراج اسکین‌ها
    final List<WeaponSkin> skinsList = (json['skins'] as List<dynamic>? ?? [])
        .map((skinJson) {
          // پیدا کردن لینک ویدیو از داخل chromas یا levels
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

    return WeaponModel(
      id: json['uuid'] ?? '',
      name: json['displayName'] ?? 'Unknown Weapon',
      category: json['category'] ?? 'Unknown',
      imageUrl: json['displayIcon'] ?? '',
      skins: skinsList,
    );
  }
}
