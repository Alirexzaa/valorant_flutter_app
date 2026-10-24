import 'package:flutter/material.dart';

import 'package:new_block/core/injection_container.dart' as di;
import 'package:new_block/core/app_router.dart'; // ← اضافه شد

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // ← تغییر کرد
      title: 'Valorant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true)
          .copyWith(scaffoldBackgroundColor: const Color(0xFF0F1923)),
      routerConfig: appRouter, // ← اینجا روتر رو وصل میکنیم
    );
  }
}
