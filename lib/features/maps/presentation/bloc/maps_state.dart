import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:new_block/features/maps/domain/entities/map.dart';

part 'maps_state.freezed.dart';

@freezed
sealed class MapsState with _$MapsState {
  const factory MapsState.initial() = MapsInitial;
  const factory MapsState.loading() = MapsLoading;
  const factory MapsState.success(List<ValorantMap> maps) = MapsSuccess;
  const factory MapsState.error(String message) = MapsError;
}
