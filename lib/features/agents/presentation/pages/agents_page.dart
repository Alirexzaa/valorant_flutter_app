import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_block/core/widgets/shimmer_loading_widget.dart';

import 'package:new_block/features/agents/presentation/bloc/agents_bloc.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_event.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_state.dart';
import 'package:new_block/core/widgets/error_view_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
                          onTap: () =>
                              context.go('/agents/details', extra: agent),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(
                                16,
                              ), // گردتر شد
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.redAccent.withValues(alpha: 0.3),
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
                                      placeholder: (context, url) =>
                                          const Center(
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
                        )
                        .animate()
                        .fadeIn(
                          duration: 400.ms,
                          delay: (index * 50).ms,
                        ) // افکت Fade
                        .slideY(
                          begin: 0.2,
                          end: 0,
                          curve: Curves.easeOutQuad,
                        ); // افکت Slide
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
