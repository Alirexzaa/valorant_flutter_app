import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShellPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShellPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            // اگر کاربر روی همون تب فعلی کلیک کرد، بره به حالت اولیه
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        backgroundColor: const Color(0xFF0F1923),
        indicatorColor: Colors.redAccent.withValues(alpha: 0.3),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.home, color: Colors.redAccent),
            label: 'خانه',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline, color: Colors.white70),
            selectedIcon: Icon(Icons.people, color: Colors.redAccent),
            label: 'ایجنت‌ها',
          ),
          NavigationDestination(
            icon: Icon(Icons.gps_fixed_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.gps_fixed, color: Colors.redAccent),
            label: 'سلاح‌ها',
          ),
          NavigationDestination(
            icon: Icon(Icons.star_border, color: Colors.white70),
            selectedIcon: Icon(Icons.star, color: Colors.redAccent),
            label: 'علاقه‌مندی',
          ),
        ],
      ),
    );
  }
}
