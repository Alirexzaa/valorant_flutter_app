import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Entities
import 'package:new_block/features/agents/domain/entities/agent.dart';
import 'package:new_block/features/favorites/presentation/pages/favorites_page.dart';
import 'package:new_block/features/maps/domain/entities/map.dart';
import 'package:new_block/features/maps/presentation/pages/map_details_page.dart';
import 'package:new_block/features/weapons/domain/entities/weapon.dart';

// Pages
import 'package:new_block/features/agents/presentation/pages/agents_page.dart';
import 'package:new_block/features/agents/presentation/pages/agent_details_page.dart';
import 'package:new_block/features/weapons/presentation/pages/weapons_page.dart';
import 'package:new_block/features/weapons/presentation/pages/weapon_details_page.dart';
import 'package:new_block/features/maps/presentation/pages/maps_page.dart';
import 'package:new_block/features/auth/presentation/pages/auth_page.dart';
import 'package:new_block/features/home/presentation/pages/main_shell_page.dart';
import 'package:new_block/features/home/presentation/pages/dashboard_page.dart';

// کلیدهای ناوبری برای هر تب
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAgentsKey = GlobalKey<NavigatorState>(
  debugLabel: 'agents',
);
final _shellNavigatorWeaponsKey = GlobalKey<NavigatorState>(
  debugLabel: 'weapons',
);
final _shellNavigatorFavoritesKey = GlobalKey<NavigatorState>(
  debugLabel: 'favorites',
);
final _shellNavigatorMapsKey = GlobalKey<NavigatorState>(debugLabel: 'maps');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final isGoingToLogin = state.matchedLocation == '/login';

    if (!isLoggedIn && !isGoingToLogin) return '/login';
    if (isLoggedIn && isGoingToLogin) return '/dashboard';
    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const AuthPage()),

    // ✅ ساختار Bottom Navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShellPage(navigationShell: navigationShell);
      },
      branches: [
        // تب ۱: خانه
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardPage(),
            ),
          ],
        ),
        // تب ۲: ایجنت‌ها
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAgentsKey,
          routes: [
            GoRoute(
              path: '/agents',
              builder: (context, state) => const AgentsPage(),
              routes: [
                GoRoute(
                  path: 'details',
                  parentNavigatorKey: _rootNavigatorKey, // تمام صفحه باز بشه
                  builder: (context, state) {
                    final agent = state.extra as Agent;
                    return AgentDetailsPage(agent: agent);
                  },
                ),
              ],
            ),
          ],
        ),
        // تب ۳: سلاح‌ها
        StatefulShellBranch(
          navigatorKey: _shellNavigatorWeaponsKey,
          routes: [
            GoRoute(
              path: '/weapons',
              builder: (context, state) => const WeaponsPage(),
              routes: [
                GoRoute(
                  path: 'details',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final weapon = state.extra as Weapon;
                    return WeaponDetailsPage(weapon: weapon);
                  },
                ),
              ],
            ),
          ],
        ),
        // تب 4 (جدید): نقشه‌ها
        StatefulShellBranch(
          navigatorKey: _shellNavigatorMapsKey,
          routes: [
            GoRoute(
              path: '/maps',
              builder: (context, state) => const MapsPage(),
              routes: [
                GoRoute(
                  path: 'details',
                  parentNavigatorKey: _rootNavigatorKey, // تمام صفحه باز بشه
                  builder: (context, state) {
                    final map = state.extra as ValorantMap;
                    return MapDetailsPage(map: map);
                  },
                ),
              ],
            ),
          ],
        ),
        // تب 5: علاقه‌مندی‌ها
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFavoritesKey,
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
