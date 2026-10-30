import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_block/l10n/app_localizations.dart'; // ✅ ایمپورت برای ترجمه

class MainShellPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShellPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    // ✅ گرفتن آبجکت ترجمه
    // به جای این:
    // final t = AppLocalizations.of(context)!;

    // ✅ این رو بنویس:
    final t = AppLocalizations.of(context) ?? AppLocalizations.of(context)!;
    // (یا حتی بهتر: اگر null بود، یه زبان پیش‌فرض مثل انگلیسی رو لود کن)

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        backgroundColor: const Color(0xFF0F1923),
        indicatorColor: Colors.redAccent.withValues(alpha: 0.3),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined, color: Colors.white70),
            selectedIcon: const Icon(Icons.home, color: Colors.redAccent),
            label: t.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.people_outline, color: Colors.white70),
            selectedIcon: const Icon(Icons.people, color: Colors.redAccent),
            label: t.agents,
          ),
          NavigationDestination(
            icon: const Icon(Icons.gps_fixed_outlined, color: Colors.white70),
            selectedIcon: const Icon(Icons.gps_fixed, color: Colors.redAccent),
            label: t.weapons,
          ),
          NavigationDestination(
            icon: const Icon(Icons.map_outlined, color: Colors.white70),
            selectedIcon: const Icon(Icons.map, color: Colors.redAccent),
            label: t.maps,
          ),
          NavigationDestination(
            icon: const Icon(Icons.star_border, color: Colors.white70),
            selectedIcon: const Icon(Icons.star, color: Colors.redAccent),
            label: t.favorites,
          ),
        ],
      ),
    );
  }
}
