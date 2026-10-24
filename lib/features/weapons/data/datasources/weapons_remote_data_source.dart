import 'package:new_block/features/weapons/data/models/weapon_model.dart';

abstract class WeaponsRemoteDataSource {
  Future<List<WeaponModel>> getWeapons();
}
