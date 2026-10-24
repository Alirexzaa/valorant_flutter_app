import 'package:new_block/features/weapons/domain/entities/weapon.dart';

class WeaponModel extends Weapon {
  const WeaponModel({
    required super.id,
    required super.name,
    required super.category,
    required super.imageUrl,
  });

  factory WeaponModel.fromJson(Map<String, dynamic> json) {
    return WeaponModel(
      id: json['uuid'] ?? '',
      name: json['displayName'] ?? 'Unknown Weapon',
      category: json['category'] ?? 'Unknown',
      imageUrl: json['displayIcon'] ?? '',
    );
  }
}
