import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:new_block/features/agents/domain/entities/agent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_bloc.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_event.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_state.dart';

class AgentDetailsPage extends StatelessWidget {
  final Agent agent;

  const AgentDetailsPage({super.key, required this.agent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(agent.name),
        backgroundColor: Colors.redAccent.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          BlocBuilder<AgentsBloc, AgentsState>(
            builder: (context, state) {
              bool isFavorite = false;
              if (state is AgentsSuccess) {
                isFavorite = state.favoriteIds.contains(agent.id);
                // ✅ این خط رو اضافه کردم تا ببینیم چی داره اتفاق میفته
                print(
                  '⭐ UI CHECK: AgentID=${agent.id}, Favorites=${state.favoriteIds}, IsFav=$isFavorite',
                );
              }
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.star : Icons.abc_outlined,
                  color: isFavorite ? Colors.yellow : Colors.white,
                ),
                onPressed: () {
                  context.read<AgentsBloc>().add(
                    ToggleFavoriteEvent(agent.id, !isFavorite),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // عکس بزرگ ایجنت
            Hero(
              tag: agent.id, // جادوی انیمیشن بین صفحات
              child: CachedNetworkImage(
                imageUrl: agent.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(color: Colors.redAccent),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.red),
              ),
            ),
            const SizedBox(height: 20),
            // اطلاعات
            Text(
              agent.name,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.redAccent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.redAccent),
              ),
              child: Text(
                agent.role,
                style: const TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'اینجا می‌تونیم بعداً اطلاعات بیشتری مثل توانایی‌های ایجنت (Abilities) رو از API بگیریم و نشون بدیم.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
