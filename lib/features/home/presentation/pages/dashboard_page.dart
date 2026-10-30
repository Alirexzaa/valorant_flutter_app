import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_block/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:new_block/features/auth/presentation/bloc/auth_event.dart';
import 'package:new_block/core/language_cubit.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_bloc.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_event.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_bloc.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_event.dart';
import 'package:new_block/l10n/app_localizations.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.appTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.redAccent.shade700, Colors.redAccent.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          // دکمه تغییر زبان
          PopupMenuButton<String>(
            icon: const Icon(Icons.language, color: Colors.white),
            tooltip: 'Select Language',
            onSelected: (String langCode) {
              context.read<LanguageCubit>().changeLanguage(langCode);
              // فچ مجدد دیتا
              context.read<AgentsBloc>().add(const FetchAgentsEvent());
              context.read<WeaponsBloc>().add(const FetchWeaponsEvent());
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(value: 'en-US', child: Text('English')),
                const PopupMenuItem(value: 'ar-AE', child: Text('العربية')),
                const PopupMenuItem(value: 'tr-TR', child: Text('Türkçe')),
                const PopupMenuItem(value: 'ru-RU', child: Text('Русский')),
                const PopupMenuItem(value: 'fr-FR', child: Text('Français')),
                const PopupMenuItem(value: 'de-DE', child: Text('Deutsch')),
                const PopupMenuItem(value: 'es-ES', child: Text('Español')),
                const PopupMenuItem(value: 'ja-JP', child: Text('日本語')),
                const PopupMenuItem(value: 'ko-KR', child: Text('한국어')),
                const PopupMenuItem(value: 'zh-CN', child: Text('中文')),
              ];
            },
          ),
          // دکمه خروج
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: t.signOut,
            onPressed: () {
              context.read<AuthBloc>().add(const SignOutRequested());
              context.go('/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.sports_esports,
              size: 100,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 20),
            Text(
              t.welcome,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildShortcutButton(context, t.agents, Icons.people, '/agents'),
            const SizedBox(height: 12),
            _buildShortcutButton(
              context,
              t.weapons,
              Icons.gps_fixed,
              '/weapons',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShortcutButton(
    BuildContext context,
    String text,
    IconData icon,
    String route,
  ) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[900],
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () => context.go(route),
      icon: Icon(icon, color: Colors.redAccent),
      label: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
