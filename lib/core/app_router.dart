import 'package:go_router/go_router.dart';
import 'package:new_block/features/maps/presentation/bloc/pages/maps_page.dart';
import 'package:new_block/features/weapons/domain/entities/weapon.dart';
import 'package:new_block/features/weapons/presentation/pages/weapon_details_page.dart';

import 'package:new_block/features/agents/domain/entities/agent.dart';
import 'package:new_block/features/agents/presentation/pages/agents_page.dart';
import 'package:new_block/features/agents/presentation/pages/agent_details_page.dart';
import 'package:new_block/features/weapons/presentation/pages/weapons_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AgentsPage()),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        // اینجا آبجکت ایجنت رو از صفحه قبل تحویل می‌گیریم
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
  ],
);
