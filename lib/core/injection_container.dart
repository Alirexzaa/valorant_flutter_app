import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:new_block/core/network/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Auth
import 'package:new_block/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:new_block/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:new_block/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:new_block/features/auth/domain/repositories/auth_repository.dart';
import 'package:new_block/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:new_block/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:new_block/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:new_block/features/auth/presentation/bloc/auth_bloc.dart';

// Agents
import 'package:new_block/features/agents/data/datasources/agents_local_data_source.dart';
import 'package:new_block/features/agents/data/datasources/agents_local_data_source_impl.dart';
import 'package:new_block/features/agents/data/datasources/agents_remote_data_source.dart';
import 'package:new_block/features/agents/data/datasources/agents_remote_data_source_impl.dart';
import 'package:new_block/features/agents/data/datasources/favorites_remote_data_source.dart';
import 'package:new_block/features/agents/data/datasources/favorites_remote_data_source_impl.dart';
import 'package:new_block/features/agents/data/repositories/agents_repository_impl.dart';
import 'package:new_block/features/agents/data/repositories/favorites_repository_impl.dart';
import 'package:new_block/features/agents/domain/repositories/agents_repository.dart';
import 'package:new_block/features/agents/domain/repositories/favorites_repository.dart';
import 'package:new_block/features/agents/domain/usecases/get_agents_usecase.dart';
import 'package:new_block/features/agents/domain/usecases/get_favorite_ids_usecase.dart';
import 'package:new_block/features/agents/domain/usecases/toggle_favorite_usecase.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_bloc.dart';

// Maps
import 'package:new_block/features/maps/data/datasources/maps_local_data_source.dart';
import 'package:new_block/features/maps/data/datasources/maps_local_data_source_impl.dart';
import 'package:new_block/features/maps/data/datasources/maps_remote_data_source.dart';
import 'package:new_block/features/maps/data/datasources/maps_remote_data_source_impl.dart';
import 'package:new_block/features/maps/data/repositories/maps_repository_impl.dart';
import 'package:new_block/features/maps/domain/repositories/maps_repository.dart';
import 'package:new_block/features/maps/domain/usecases/get_maps_usecase.dart';
import 'package:new_block/features/maps/presentation/bloc/maps_bloc.dart';

// Weapons
import 'package:new_block/features/weapons/data/datasources/weapons_local_data_source.dart';
import 'package:new_block/features/weapons/data/datasources/weapons_local_data_source_impl.dart';
import 'package:new_block/features/weapons/data/datasources/weapons_remote_data_source.dart';
import 'package:new_block/features/weapons/data/datasources/weapons_remote_data_source_impl.dart';
import 'package:new_block/features/weapons/data/repositories/weapons_repository_impl.dart';
import 'package:new_block/features/weapons/domain/repositories/weapons_repository.dart';
import 'package:new_block/features/weapons/domain/usecases/get_weapons_usecase.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_bloc.dart';
import 'package:new_block/features/weapons/data/datasources/weapon_favorites_remote_data_source.dart';
import 'package:new_block/features/weapons/data/datasources/weapon_favorites_remote_data_source_impl.dart';
import 'package:new_block/features/weapons/data/repositories/weapon_favorites_repository_impl.dart';
import 'package:new_block/features/weapons/domain/repositories/weapon_favorites_repository.dart';
import 'package:new_block/features/weapons/domain/usecases/get_favorite_weapon_ids_usecase.dart';
import 'package:new_block/features/weapons/domain/usecases/toggle_weapon_favorite_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ═══════════════════════════════════════════
  // Agents Feature
  // ═══════════════════════════════════════════
  sl.registerFactory(
    () => AgentsBloc(
      getAgentsUseCase: sl(),
      toggleFavoriteUseCase: sl(),
      getFavoriteIdsUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetAgentsUseCase(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => GetFavoriteIdsUseCase(sl()));

  sl.registerLazySingleton<AgentsRepository>(
    () => AgentsRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  sl.registerLazySingleton<AgentsRemoteDataSource>(
    () => AgentsRemoteDataSourceImpl(dioClient: sl()),
  );
  sl.registerLazySingleton<AgentsLocalDataSource>(
    () => AgentsLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Favorites (وابسته به Agents)
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<FavoritesRemoteDataSource>(
    () => FavoritesRemoteDataSourceImpl(firestore: sl(), firebaseAuth: sl()),
  );

  // ═══════════════════════════════════════════
  // Weapons Feature
  // ═══════════════════════════════════════════
  sl.registerFactory(
    () => WeaponsBloc(
      getWeaponsUseCase: sl(),
      toggleFavoriteUseCase: sl(),
      getFavoriteIdsUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetWeaponsUseCase(sl()));
  sl.registerLazySingleton<WeaponsRepository>(
    () => WeaponsRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  sl.registerLazySingleton<WeaponsRemoteDataSource>(
    () => WeaponsRemoteDataSourceImpl(dioClient: sl()),
  );
  sl.registerLazySingleton<WeaponsLocalDataSource>(
    () => WeaponsLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton(() => ToggleWeaponFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => GetFavoriteWeaponIdsUseCase(sl()));

  sl.registerLazySingleton<WeaponFavoritesRepository>(
    () => WeaponFavoritesRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<WeaponFavoritesRemoteDataSource>(
    () => WeaponFavoritesRemoteDataSourceImpl(
      firestore: sl(),
      firebaseAuth: sl(),
    ),
  );

  // ═══════════════════════════════════════════
  // Maps Feature
  // ═══════════════════════════════════════════
  sl.registerFactory(() => MapsBloc(getMapsUseCase: sl()));
  sl.registerLazySingleton(() => GetMapsUseCase(sl()));
  sl.registerLazySingleton<MapsRepository>(
    () => MapsRepositoryImpl(
      remoteDataSource: sl<MapsRemoteDataSource>(),
      localDataSource: sl<MapsLocalDataSource>(),
    ),
  );
  sl.registerLazySingleton<MapsRemoteDataSource>(
    () => MapsRemoteDataSourceImpl(dioClient: sl()),
  );
  sl.registerLazySingleton<MapsLocalDataSource>(
    () => MapsLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // ═══════════════════════════════════════════
  // Auth Feature
  // ═══════════════════════════════════════════
  sl.registerFactory(
    () => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      signOutUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl()),
  );

  // ═══════════════════════════════════════════
  // External / Core
  // ═══════════════════════════════════════════
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => DioClient());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
