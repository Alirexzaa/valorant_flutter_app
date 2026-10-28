import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart'; // ← فایلی که flutterfire ساخت
import 'core/injection_container.dart' as di;
import 'core/app_router.dart';

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
    return MaterialApp.router(
      title: 'Valorant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true)
          .copyWith(scaffoldBackgroundColor: const Color(0xFF0F1923)),
      routerConfig: appRouter,
    );
  }
}
