import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:new_block/features/maps/domain/usecases/get_maps_usecase.dart';
import 'package:new_block/features/maps/presentation/bloc/maps_event.dart';
import 'package:new_block/features/maps/presentation/bloc/maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  final GetMapsUseCase getMapsUseCase;

  MapsBloc({required this.getMapsUseCase}) : super(const MapsState.initial()) {
    on<FetchMapsEvent>((event, emit) async {
      emit(const MapsState.loading());
      final result = await getMapsUseCase();
      result.fold(
        (failure) => emit(MapsState.error(failure.message)),
        (maps) => emit(MapsState.success(maps)),
      );
    }, transformer: droppable());
  }
}
