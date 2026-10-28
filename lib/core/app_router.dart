import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_block/features/agents/domain/entities/agent.dart';
import 'package:new_block/features/agents/presentation/pages/favorites_page.dart';
import 'package:new_block/features/auth/presentation/bloc/pages/auth_page.dart';
import 'package:new_block/features/maps/presentation/bloc/pages/maps_page.dart';
import 'package:new_block/features/weapons/domain/entities/weapon.dart';
import 'package:new_block/features/agents/presentation/pages/agents_page.dart';
import 'package:new_block/features/agents/presentation/pages/agent_details_page.dart';
import 'package:new_block/features/weapons/presentation/pages/weapons_page.dart';
import 'package:new_block/features/weapons/presentation/pages/weapon_details_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login', // ✅ شروع برنامه از صفحه لاگین
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const AuthPage()),
    GoRoute(path: '/', builder: (context, state) => const AgentsPage()),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final agent = state.extra as Agent;
        return AgentDetailsPage(agent: agent);
      },
    ),
    GoRoute(path: '/weapons', builder: (context, state) => const WeaponsPage()),
    GoRoute(
      path: '/weapon-details',
      builder: (context, state) {
        final weapon = state.extra as Weapon;
        return WeaponDetailsPage(weapon: weapon);
      },
    ),
    GoRoute(path: '/maps', builder: (context, state) => const MapsPage()),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesPage(),
    ),
  ],
  // ✅ این بخش جادویی است: اگر کاربر لاگین نکرده باشد و بخواهد وارد صفحه‌ای شود، به لاگین هدایتش می‌کند
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final isGoingToLogin = state.matchedLocation == '/login';

    if (!isLoggedIn && !isGoingToLogin) {
      return '/login'; // هدایت به لاگین
    }
    if (isLoggedIn && isGoingToLogin) {
      return '/'; // اگر لاگین بود و توی صفحه لاگین بود، ببرش به خانه
    }
    return null; // اجازه عبور بده
  },
);
