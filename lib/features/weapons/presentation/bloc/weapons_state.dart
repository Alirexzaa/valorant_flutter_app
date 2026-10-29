import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:new_block/features/weapons/domain/entities/weapon.dart';

part 'weapons_state.freezed.dart';

@freezed
sealed class WeaponsState with _$WeaponsState {
  const factory WeaponsState.initial() = WeaponsInitial;
  const factory WeaponsState.loading() = WeaponsLoading;
  const factory WeaponsState.success(
    List<Weapon> weapons,
    List<String> favoriteIds,
  ) = WeaponsSuccess;
  const factory WeaponsState.error(String message) = WeaponsError;
}
