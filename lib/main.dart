import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // ✅ برای زبان‌ها
import 'package:new_block/l10n/app_localizations.dart'; // ✅ فایل تولید شده ترجمه
import 'package:new_block/core/language_cubit.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_bloc.dart';
import 'package:new_block/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_bloc.dart';

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
        BlocProvider(create: (_) => di.sl<WeaponsBloc>()),
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<AgentsBloc>()),
        BlocProvider(create: (_) => di.sl<LanguageCubit>()),
      ],
      // ✅ اینجا از BlocBuilder استفاده می‌کنیم تا وقتی زبان عوض میشه، کل اپ آپدیت بشه
      child: BlocBuilder<LanguageCubit, String>(
        builder: (context, languageCode) {
          // تبدیل کد زبان (مثل ar-AE) به Locale (مثل ar)
          final locale = Locale(languageCode.split('-')[0]);

          return MaterialApp.router(
            title: 'Valorant App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(useMaterial3: true)
                .copyWith(scaffoldBackgroundColor: const Color(0xFF0F1923)),
            routerConfig: appRouter,
            locale: locale, // ✅ تنظیم زبان فعلی
            localizationsDelegates: const [
              AppLocalizations.delegate, // ✅ دیکشنری ترجمه‌های ما
              GlobalMaterialLocalizations.delegate, // ✅ ترجمه‌های خود فلاتر
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('fa'), // Persian
              Locale('ar'), // Arabic
              Locale('de'), // German
              Locale('es'), // Spanish
              Locale('fr'), // French
              Locale('id'), // Indonesian
              Locale('it'), // Italian
              Locale('ja'), // Japanese
              Locale('ko'), // Korean
              Locale('pl'), // Polish
              Locale('pt'), // Portuguese
              Locale('ru'), // Russian
              Locale('th'), // Thai
              Locale('tr'), // Turkish
              Locale('vi'), // Vietnamese
              Locale('zh'), // Chinese
            ],
          );
        },
      ),
    );
  }
}
