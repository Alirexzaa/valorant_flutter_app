import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/maps/domain/entities/map.dart';
import 'package:new_block/features/maps/domain/repositories/maps_repository.dart';

class GetMapsUseCase {
  final MapsRepository repository;

  GetMapsUseCase(this.repository);

  Future<Either<Failure, List<ValorantMap>>> call() async {
    return await repository.getMaps();
  }
}
