import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:new_block/features/agents/presentation/bloc/agents_bloc.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('علاقه‌مندی‌ها'),
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: BlocBuilder<AgentsBloc, AgentsState>(
        builder: (context, state) {
          if (state is AgentsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            );
          }

          if (state is AgentsSuccess) {
            // فیلتر کردن ایجنت‌هایی که آیدیشون توی لیست علاقه‌مندی‌هاست
            final favoriteAgents = state.agents
                .where((agent) => state.favoriteIds.contains(agent.id))
                .toList();

            if (favoriteAgents.isEmpty) {
              return const Center(
                child: Text('هنوز هیچ ایجنتی رو ستاره نکردی!'),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: favoriteAgents.length,
              itemBuilder: (context, index) {
                final agent = favoriteAgents[index];
                return GestureDetector(
                  onTap: () {
                    context.push('/details', extra: agent);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.yellow,
                        width: 2,
                      ), // حاشیه زرد برای علاقه‌مندی‌ها
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
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
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

          return const Center(child: Text('در حال بارگذاری...'));
        },
      ),
    );
  }
}
