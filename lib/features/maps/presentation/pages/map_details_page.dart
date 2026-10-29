import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_block/features/maps/domain/entities/map.dart';

class MapDetailsPage extends StatelessWidget {
  final ValorantMap map;
  const MapDetailsPage({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1923),
      body: CustomScrollView(
        slivers: [
          // ۱. هدر صفحه (عکس بزرگ با گرادیانت)
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            backgroundColor: Colors.redAccent.shade700,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                map.name.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: map.splashUrl,
                    fit: BoxFit.cover,
                    errorWidget: (c, u, e) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                  // گرادیانت تیره برای خوانایی متن
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, const Color(0xFF0F1923)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ۲. بخش نقشه تاکتیکی
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'نقشه تاکتیکی',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.redAccent.withValues(alpha: 0.3),
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: map.tacticalMapUrl,
                      fit: BoxFit.contain,
                      height: 250,
                      errorWidget: (c, u, e) =>
                          const Center(child: Text('نقشه در دسترس نیست')),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ۳. بخش نقاط استراتژیک (Callouts)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'نقاط استراتژیک (Callouts)',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // نمایش نقاط به صورت Chip
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: map.callouts.map((callout) {
                      return Chip(
                        label: Text(
                          callout,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.grey[800],
                        side: BorderSide(
                          color: Colors.redAccent.withValues(alpha: 0.5),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 40), // فاصله برای اسکرول راحت‌تر
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
