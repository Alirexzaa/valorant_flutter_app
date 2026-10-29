import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:new_block/features/weapons/domain/usecases/get_favorite_weapon_ids_usecase.dart';

import 'package:new_block/features/weapons/domain/usecases/get_weapons_usecase.dart';
import 'package:new_block/features/weapons/domain/usecases/toggle_weapon_favorite_usecase.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_event.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_state.dart';

class WeaponsBloc extends Bloc<WeaponsEvent, WeaponsState> {
  final GetWeaponsUseCase getWeaponsUseCase;
  final ToggleWeaponFavoriteUseCase toggleFavoriteUseCase;
  final GetFavoriteWeaponIdsUseCase getFavoriteIdsUseCase;

  WeaponsBloc({
    required this.getWeaponsUseCase,
    required this.toggleFavoriteUseCase,
    required this.getFavoriteIdsUseCase,
  }) : super(const WeaponsState.initial()) {
    on<FetchWeaponsEvent>((event, emit) async {
      emit(const WeaponsState.loading());
      final result = await getWeaponsUseCase();
      final favoritesResult = await getFavoriteIdsUseCase();

      result.fold((failure) => emit(WeaponsState.error(failure.message)), (
        weapons,
      ) {
        favoritesResult.fold(
          (l) => emit(WeaponsState.success(weapons, [])),
          (favoriteIds) => emit(WeaponsState.success(weapons, favoriteIds)),
        );
      });
    }, transformer: droppable());

    on<ToggleWeaponFavoriteEvent>((event, emit) async {
      final result = await toggleFavoriteUseCase(
        event.weaponId,
        event.isFavorite,
      );
      result.fold((l) => emit(WeaponsState.error(l.message)), (_) {
        if (state is WeaponsSuccess) {
          final currentState = state as WeaponsSuccess;
          final newFavorites = List<String>.from(currentState.favoriteIds);

          if (event.isFavorite) {
            if (!newFavorites.contains(event.weaponId))
              newFavorites.add(event.weaponId);
          } else {
            newFavorites.remove(event.weaponId);
          }
          emit(WeaponsState.success(currentState.weapons, newFavorites));
        }
      });
    });
  }
}
