import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_block/features/agents/domain/entities/agent.dart';
import 'package:new_block/features/agents/domain/usecases/get_agents_usecase.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_event.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_state.dart';

import 'package:rxdart/rxdart.dart'; // ← این ایمپورت رو اضافه کن

// ═══════════════════════════════════════════
// ساخت EventTransformer سفارشی برای Debounce
// ═══════════════════════════════════════════
EventTransformer<T> debounceTime<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class AgentsBloc extends Bloc<AgentsEvent, AgentsState> {
  final GetAgentsUseCase getAgentsUseCase;

  // یه لیست خصوصی برای نگه داشتن همه ایجنت‌ها (تا وقتی سرچ میکنیم، لیست اصلیمون رو از دست ندیم)
  List<Agent> _allAgents = [];

  AgentsBloc({required this.getAgentsUseCase})
    : super(const AgentsState.initial()) {
    // مدیریت رویداد Fetch (همون قبلی)
    on<FetchAgentsEvent>(_onFetchAgents, transformer: droppable());

    // مدیریت رویداد Search (جدید!)
    on<SearchAgentsEvent>(
      _onSearchAgents,
      transformer: debounceTime(
        const Duration(milliseconds: 500),
      ), // ← جادوی مسیر A
    );
  }

  Future<void> _onFetchAgents(
    FetchAgentsEvent event,
    Emitter<AgentsState> emit,
  ) async {
    emit(const AgentsState.loading());

    // ۱. UseCase رو صدا میزنیم (که الان یه Either برمیگردونه)
    final result = await getAgentsUseCase();

    // ۲. با fold تصمیم میگیریم چی کار کنیم
    result.fold(
      (failure) {
        // ❌ حالت خطا (Left)
        emit(AgentsState.error(failure.message));
      },
      (agents) {
        // ✅ حالت موفقیت (Right)
        _allAgents = agents; // لیست اصلی رو برای جستجو (Search) ذخیره میکنیم
        emit(AgentsState.success(agents));
      },
    );
  }

  void _onSearchAgents(SearchAgentsEvent event, Emitter<AgentsState> emit) {
    // اگه هنوز لیستی لود نشده، کاری نکن
    if (_allAgents.isEmpty) return;

    final query = event.query.toLowerCase().trim();

    if (query.isEmpty) {
      // اگه کاربر سرچ رو پاک کرد، همه ایجنت‌ها رو نشون بده
      emit(AgentsState.success(_allAgents));
    } else {
      // فیلتر کردن ایجنت‌ها بر اساس حروفی که کاربر تایپ کرده
      final filteredAgents = _allAgents
          .where((agent) => agent.name.toLowerCase().contains(query))
          .toList();
      emit(AgentsState.success(filteredAgents));
    }
  }
}
