import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:new_block/features/weapons/data/models/weapon_model.dart';
import 'package:new_block/features/weapons/data/datasources/weapons_local_data_source.dart';

class WeaponsLocalDataSourceImpl implements WeaponsLocalDataSource {
  final SharedPreferences sharedPreferences;

  // یه کلید جدید برای سلاح‌ها (تا با ایجنت‌ها قاطی نشه)
  static const cachedWeaponsKey = 'CACHED_WEAPONS';

  WeaponsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<WeaponModel>> getLastWeapons() async {
    final jsonString = sharedPreferences.getString(cachedWeaponsKey);
    if (jsonString != null) {
      final List decodedJson = json.decode(jsonString);
      return decodedJson.map((json) => WeaponModel.fromJson(json)).toList();
    } else {
      throw Exception('No cached weapons');
    }
  }

  @override
  Future<void> cacheWeapons(List<WeaponModel> weaponsToCache) async {
    // تبدیل لیست سلاح‌ها به JSON برای ذخیره در SharedPreferences
    final jsonString = json.encode(
      weaponsToCache
          .map(
            (weapon) => {
              'uuid': weapon.id,
              'displayName': weapon.name,
              'category': weapon.category,
              'displayIcon': weapon.imageUrl,
            },
          )
          .toList(),
    );
    await sharedPreferences.setString(cachedWeaponsKey, jsonString);
  }
}
