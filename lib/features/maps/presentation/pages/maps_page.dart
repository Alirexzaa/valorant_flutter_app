import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:new_block/core/injection_container.dart';
import 'package:new_block/core/widgets/error_view_widget.dart';
import 'package:new_block/core/widgets/shimmer_loading_widget.dart';
import 'package:new_block/features/maps/presentation/bloc/maps_bloc.dart';
import 'package:new_block/features/maps/presentation/bloc/maps_event.dart';
import 'package:new_block/features/maps/presentation/bloc/maps_state.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MapsBloc>()..add(const FetchMapsEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Valorant Maps',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.redAccent.shade700,
                      Colors.redAccent.shade200,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            body: BlocBuilder<MapsBloc, MapsState>(
              builder: (context, state) {
                return switch (state) {
                  MapsInitial() => const Center(child: Text('آماده شروع...')),
                  MapsLoading() => const ShimmerLoadingWidget(),
                  MapsSuccess(maps: final maps) => GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemCount: maps.length,
                    itemBuilder: (context, index) {
                      final map = maps[index];
                      return GestureDetector(
                            onTap: () {
                              context.push('/maps/details', extra: map);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.redAccent.withValues(
                                    alpha: 0.3,
                                  ),
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
                                        imageUrl: map.imageUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        placeholder: (context, url) =>
                                            const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                              Icons.map,
                                              size: 50,
                                              color: Colors.grey,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      map.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 400.ms, delay: (index * 50).ms)
                          .slideY(
                            begin: 0.2,
                            end: 0,
                            curve: Curves.easeOutQuad,
                          );
                    },
                  ),
                  MapsError(message: final msg) => ErrorViewWidget(
                    message: msg,
                    onRetry: () =>
                        context.read<MapsBloc>().add(const FetchMapsEvent()),
                  ),
                };
              },
            ),
          );
        },
      ),
    );
  }
}
