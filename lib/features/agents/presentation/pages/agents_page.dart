import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_block/core/widgets/shimmer_loading_widget.dart';

import 'package:new_block/features/agents/presentation/bloc/agents_bloc.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_event.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_state.dart';
import 'package:new_block/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:new_block/features/auth/presentation/bloc/auth_event.dart';
import 'package:new_block/core/widgets/error_view_widget.dart';

class AgentsPage extends StatefulWidget {
  const AgentsPage({super.key});

  @override
  State<AgentsPage> createState() => _AgentsPageState();
}

class _AgentsPageState extends State<AgentsPage> {
  @override
  void initState() {
    super.initState();
    // ✅ فچ کردن دیتا موقع باز شدن صفحه
    context.read<AgentsBloc>().add(const FetchAgentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent.shade700,
        title: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'name',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.white),
          ),
          onChanged: (value) {
            context.read<AgentsBloc>().add(SearchAgentsEvent(value));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.gps_fixed, color: Colors.white),
            onPressed: () => context.push('/weapons'),
            tooltip: 'سلاح‌ها',
          ),
          IconButton(
            icon: const Icon(Icons.map, color: Colors.white),
            onPressed: () => context.push('/maps'),
            tooltip: 'نقشه‌ها',
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'خروج',
            onPressed: () {
              context.read<AuthBloc>().add(const SignOutRequested());
              context.go('/login');
            },
          ),
        ],
      ),
      body: BlocBuilder<AgentsBloc, AgentsState>(
        builder: (context, state) {
          return switch (state) {
            AgentsInitial() => const Center(child: Text('آماده شروع...')),
            AgentsLoading() => const ShimmerLoadingWidget(),
            AgentsSuccess(agents: final agents, favoriteIds: final _) =>
              RefreshIndicator(
                color: Colors.redAccent,
                onRefresh: () async {
                  context.read<AgentsBloc>().add(const FetchAgentsEvent());
                },
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: agents.length,
                  itemBuilder: (context, index) {
                    final agent = agents[index];
                    return GestureDetector(
                      onTap: () {
                        context.push('/details', extra: agent);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.redAccent.withValues(alpha: 0.5),
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
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    agent.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    agent.role,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            AgentsError(message: final msg) => ErrorViewWidget(
              message: msg,
              onRetry: () {
                context.read<AgentsBloc>().add(const FetchAgentsEvent());
              },
            ),
          };
        },
      ),
    );
  }
}
