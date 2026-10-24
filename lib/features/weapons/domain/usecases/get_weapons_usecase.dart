import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/weapons/domain/entities/weapon.dart';
import 'package:new_block/features/weapons/domain/repositories/weapons_repository.dart';

class GetWeaponsUseCase {
  final WeaponsRepository repository;

  GetWeaponsUseCase(this.repository);

  Future<Either<Failure, List<Weapon>>> call() async {
    return await repository.getWeapons();
  }
}
