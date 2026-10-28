import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_bloc.dart';
import 'package:new_block/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:new_block/firebase_options.dart';
import 'package:new_block/core/injection_container.dart' as di;
import 'package:new_block/core/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ⬇️ راه‌اندازی Firebase با تنظیمات خودکار
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<AgentsBloc>()), // ✅ اضافه شد
      ],
      child: MaterialApp.router(
        title: 'Valorant App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true)
            .copyWith(scaffoldBackgroundColor: const Color(0xFF0F1923)),
        routerConfig: appRouter,
      ),
    );
  }
}
