import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:new_block/core/network/dio_client.dart';
import 'package:new_block/features/maps/data/datasources/maps_local_data_source.dart';
import 'package:new_block/features/maps/data/datasources/maps_local_data_source_impl.dart';
import 'package:new_block/features/maps/data/datasources/maps_remote_data_source.dart';
import 'package:new_block/features/maps/data/datasources/maps_remote_data_source_impl.dart';
import 'package:new_block/features/maps/data/repositories/maps_repository_impl.dart';
import 'package:new_block/features/maps/domain/repositories/maps_repository.dart';
import 'package:new_block/features/maps/domain/usecase/get_maps_usecase.dart';
import 'package:new_block/features/maps/presentation/bloc/maps_bloc.dart';
import 'package:new_block/features/weapons/data/datasources/weapons_remote_data_source.dart';
import 'package:new_block/features/weapons/data/datasources/weapons_remote_data_source_impl.dart';
import 'package:new_block/features/weapons/data/repositories/weapons_repository_impl.dart';
import 'package:new_block/features/weapons/domain/repositories/weapons_repository.dart';
import 'package:new_block/features/weapons/domain/usecases/get_weapons_usecase.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ← اضافه شد

import 'package:new_block/features/agents/data/datasources/agents_local_data_source.dart'; // ← اضافه شد
import 'package:new_block/features/agents/data/datasources/agents_local_data_source_impl.dart'; // ← اضافه شد
import 'package:new_block/features/agents/data/datasources/agents_remote_data_source.dart';
import 'package:new_block/features/agents/data/datasources/agents_remote_data_source_impl.dart';
import 'package:new_block/features/agents/data/repositories/agents_repository_impl.dart';
import 'package:new_block/features/agents/domain/repositories/agents_repository.dart';
import 'package:new_block/features/agents/domain/usecases/get_agents_usecase.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_bloc.dart';

import 'package:new_block/features/weapons/data/datasources/weapons_local_data_source.dart';
import 'package:new_block/features/weapons/data/datasources/weapons_local_data_source_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Presentation
  sl.registerFactory(() => AgentsBloc(getAgentsUseCase: sl()));

  // Domain
  sl.registerLazySingleton(() => GetAgentsUseCase(sl()));

  // Data
  sl.registerLazySingleton<AgentsRepository>(
    () => AgentsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(), // ← تزریق دیتابیس محلی
    ),
  );

  sl.registerLazySingleton<AgentsRemoteDataSource>(
    () => AgentsRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AgentsLocalDataSource>(
    () => AgentsLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());

  // ═══════════════════════════════════════════
  // Weapons Feature
  // ═══════════════════════════════════════════
  sl.registerFactory(() => WeaponsBloc(getWeaponsUseCase: sl()));
  sl.registerLazySingleton(() => GetWeaponsUseCase(sl()));

  // ⬇️ اینجا localDataSource رو به Repository پاس میدیم
  sl.registerLazySingleton<WeaponsRepository>(
    () => WeaponsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(), // ← این خط اضافه شد
    ),
  );

  sl.registerLazySingleton<WeaponsRemoteDataSource>(
    () => WeaponsRemoteDataSourceImpl(dioClient: sl()),
  );

  // ⬇️ این ثبت جدید برای LocalDataSource سلاح‌هاست
  sl.registerLazySingleton<WeaponsLocalDataSource>(
    () => WeaponsLocalDataSourceImpl(sharedPreferences: sl()),
  );
  // Register DioClient (فقط یک بار در کل اپ)
  sl.registerLazySingleton(() => DioClient());

  // ⚠️ مهم: SharedPreferences باید قبل از استفاده مقداردهی بشه
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Maps Feature
  sl.registerFactory(() => MapsBloc(getMapsUseCase: sl()));
  sl.registerLazySingleton(() => GetMapsUseCase(sl()));

  sl.registerLazySingleton<MapsRepository>(
    () => MapsRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  sl.registerLazySingleton<MapsRemoteDataSource>(
    () => MapsRemoteDataSourceImpl(dioClient: sl()),
  );

  sl.registerLazySingleton<MapsLocalDataSource>(
    () => MapsLocalDataSourceImpl(sharedPreferences: sl()),
  );
}
