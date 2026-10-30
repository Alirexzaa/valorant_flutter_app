import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:new_block/features/agents/presentation/bloc/agents_bloc.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_state.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_bloc.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_state.dart';
import 'package:new_block/l10n/app_localizations.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            t.favorites,
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
          bottom: TabBar(
            indicatorColor: Colors.yellow,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: const Icon(Icons.people), text: t.agents),
              Tab(icon: const Icon(Icons.gps_fixed), text: t.weapons),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_FavoriteAgentsTab(), _FavoriteWeaponsTab()],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// تب ایجنت‌های محبوب
// ═══════════════════════════════════════════
class _FavoriteAgentsTab extends StatelessWidget {
  const _FavoriteAgentsTab();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BlocBuilder<AgentsBloc, AgentsState>(
      builder: (context, state) {
        if (state is AgentsSuccess) {
          final favorites = state.agents
              .where((a) => state.favoriteIds.contains(a.id))
              .toList();
          if (favorites.isEmpty) return Center(child: Text(t.noFavorites));

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final agent = favorites[index];
              return GestureDetector(
                onTap: () => context.push('/agents/details', extra: agent),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.yellow.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: agent.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          agent.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

// ═══════════════════════════════════════════
// تب سلاح‌های محبوب
// ═══════════════════════════════════════════
class _FavoriteWeaponsTab extends StatelessWidget {
  const _FavoriteWeaponsTab();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BlocBuilder<WeaponsBloc, WeaponsState>(
      builder: (context, state) {
        if (state is WeaponsSuccess) {
          final favorites = state.weapons
              .where((w) => state.favoriteIds.contains(w.id))
              .toList();
          if (favorites.isEmpty) return Center(child: Text(t.noFavorites));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final weapon = favorites[index];
              return GestureDetector(
                onTap: () => context.push('/weapons/details', extra: weapon),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.yellow.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 60,
                        child: CachedNetworkImage(
                          imageUrl: weapon.imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          weapon.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
