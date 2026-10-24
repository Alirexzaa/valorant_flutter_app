import 'package:new_block/features/weapons/data/models/weapon_model.dart';

abstract class WeaponsLocalDataSource {
  Future<List<WeaponModel>> getLastWeapons();
  Future<void> cacheWeapons(List<WeaponModel> weaponsToCache);
}
