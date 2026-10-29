import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

import 'package:new_block/core/injection_container.dart';
import 'package:new_block/core/widgets/error_view_widget.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_bloc.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_event.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_state.dart';

class WeaponsPage extends StatelessWidget {
  const WeaponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WeaponsBloc>()..add(const FetchWeaponsEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Valorant Weapons'),
              backgroundColor: Colors.redAccent.shade700,
            ),
            body: BlocBuilder<WeaponsBloc, WeaponsState>(
              builder: (context, state) {
                return switch (state) {
                  WeaponsInitial() => const Center(
                    child: Text('آماده شروع...'),
                  ),
                  WeaponsLoading() => const Center(
                    child: CircularProgressIndicator(color: Colors.redAccent),
                  ),
                  WeaponsSuccess(weapons: final weapons) => ListView.builder(
                    itemCount: weapons.length,
                    itemBuilder: (context, index) {
                      final weapon = weapons[index];
                      return InkWell(
                        onTap: () =>
                            context.push('/weapons/details', extra: weapon),
                        child: ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: weapon.imageUrl,
                            width: 80,
                            fit: BoxFit.contain,
                            errorWidget: (c, u, e) => const Icon(Icons.error),
                          ),
                          title: Text(
                            weapon.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            weapon.category,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  ),
                  WeaponsError(message: final msg) => ErrorViewWidget(
                    message: msg,
                    onRetry: () {
                      context.read<WeaponsBloc>().add(
                        const FetchWeaponsEvent(),
                      );
                    },
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
