import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_block/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:new_block/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Valorant App',
          style: TextStyle(fontWeight: FontWeight.bold),
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
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
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
            const Text(
              'به اپ والورانت خوش آمدید!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            // دکمه‌های میانبر برای رفتن به تب‌ها
            _buildShortcutButton(
              context,
              'مشاهده ایجنت‌ها',
              Icons.people,
              '/agents',
            ),
            const SizedBox(height: 12),
            _buildShortcutButton(
              context,
              'مشاهده سلاح‌ها',
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
