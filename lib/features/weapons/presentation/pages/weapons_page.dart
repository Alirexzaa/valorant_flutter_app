import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:new_block/core/injection_container.dart';
import 'package:new_block/core/widgets/error_view_widget.dart';
import 'package:new_block/features/weapons/domain/entities/weapon.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_bloc.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_event.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_state.dart';

class WeaponsPage extends StatefulWidget {
  const WeaponsPage({super.key});

  @override
  State<WeaponsPage> createState() => _WeaponsPageState();
}

class _WeaponsPageState extends State<WeaponsPage> {
  String selectedCategory = 'All'; // دسته‌بندی پیش‌فرض

  final List<String> categories = [
    'All',
    'Sidearm',
    'SMG',
    'Rifle',
    'Shotgun',
    'Sniper',
    'Heavy',
    'Melee',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WeaponsBloc>()..add(const FetchWeaponsEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Valorant Weapons',
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
            body: BlocBuilder<WeaponsBloc, WeaponsState>(
              builder: (context, state) {
                return switch (state) {
                  WeaponsInitial() => const Center(
                    child: Text('آماده شروع...'),
                  ),
                  WeaponsLoading() => const Center(
                    child: CircularProgressIndicator(color: Colors.redAccent),
                  ),

                  WeaponsSuccess(weapons: final weapons) => Column(
                    children: [
                      // ✅ نوار فیلتر افقی
                      _buildFilterBar(),

                      // لیست سلاح‌ها
                      Expanded(child: _buildWeaponsList(weapons)),
                    ],
                  ),

                  WeaponsError(message: final msg) => ErrorViewWidget(
                    message: msg,
                    onRetry: () => context.read<WeaponsBloc>().add(
                      const FetchWeaponsEvent(),
                    ),
                  ),
                };
              },
            ),
          );
        },
      ),
    );
  }

  // ساخت نوار فیلتر
  Widget _buildFilterBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white12)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              onSelected: (bool selected) {
                setState(() {
                  selectedCategory = category;
                });
              },
              backgroundColor: Colors.grey[900],
              selectedColor: Colors.redAccent,
              checkmarkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              side: BorderSide(
                color: isSelected ? Colors.redAccent : Colors.white12,
              ),
            ),
          );
        },
      ),
    );
  }

  // ساخت لیست فیلتر شده
  Widget _buildWeaponsList(List<Weapon> allWeapons) {
    // فیلتر کردن بر اساس دسته‌بندی انتخاب شده
    final filteredWeapons = selectedCategory == 'All'
        ? allWeapons
        : allWeapons.where((w) => w.category == selectedCategory).toList();

    if (filteredWeapons.isEmpty) {
      return const Center(
        child: Text(
          'سلاحی در این دسته‌بندی وجود ندارد.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredWeapons.length,
      itemBuilder: (context, index) {
        final weapon = filteredWeapons[index];
        return GestureDetector(
              onTap: () => context.push('/weapons/details', extra: weapon),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.redAccent.withValues(alpha: 0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // عکس سلاح
                    Container(
                      width: 120,
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Hero(
                        tag: 'weapon-${weapon.id}',
                        child: CachedNetworkImage(
                          imageUrl: weapon.imageUrl,
                          fit: BoxFit.contain,
                          errorWidget: (c, u, e) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // اطلاعات سلاح
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            weapon.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            weapon.category,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.redAccent,
                      size: 20,
                    ),
                  ],
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 400.ms, delay: (index * 50).ms)
            .slideX(begin: 0.1, end: 0, curve: Curves.easeOutQuad);
      },
    );
  }
}
