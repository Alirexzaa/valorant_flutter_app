import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/maps/domain/entities/map.dart'; // ✅

abstract class MapsRepository {
  Future<Either<Failure, List<ValorantMap>>> getMaps(); // ✅
}
