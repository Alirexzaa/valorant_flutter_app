import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/weapons/domain/entities/weapon.dart';

abstract class WeaponsRepository {
  // ✅ به جای Future<List<Weapon>>، از Either استفاده میکنیم
  Future<Either<Failure, List<Weapon>>> getWeapons();
}
