import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:new_block/features/weapons/domain/usecases/get_weapons_usecase.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_event.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_state.dart';

class WeaponsBloc extends Bloc<WeaponsEvent, WeaponsState> {
  final GetWeaponsUseCase getWeaponsUseCase;

  WeaponsBloc({required this.getWeaponsUseCase})
    : super(WeaponsState.initial()) {
    on<FetchWeaponsEvent>(fetchWeapons, transformer: droppable());
  }

  Future<void> fetchWeapons(
    FetchWeaponsEvent event,
    Emitter<WeaponsState> emit,
  ) async {
    emit(const WeaponsState.loading());

    final result = await getWeaponsUseCase();

    // ✅ جادوی fpdart: fold میاد و هندل میکنه
    result.fold(
      (failure) => emit(WeaponsState.error(failure.message)), // اگه Left بود
      (weapons) => emit(WeaponsState.success(weapons)), // اگه Right بود
    );
  }
}
