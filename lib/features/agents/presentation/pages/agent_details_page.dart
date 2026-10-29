import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_block/features/agents/domain/entities/agent.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_bloc.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_event.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_state.dart';

class AgentDetailsPage extends StatefulWidget {
  final Agent agent;
  const AgentDetailsPage({super.key, required this.agent});

  @override
  State<AgentDetailsPage> createState() => _AgentDetailsPageState();
}

class _AgentDetailsPageState extends State<AgentDetailsPage> {
  int selectedAbilityIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // گرفتن رنگ‌های پس‌زمینه ایجنت (اگر خالی بود، یه پیش‌فرض می‌ذاریم)
    final colors = widget.agent.backgroundColors.isNotEmpty
        ? widget.agent.backgroundColors.map((c) => HexColor(c)).toList()
        : [Colors.redAccent, const Color(0xFF0F1923)];

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors.length >= 2
                ? [colors[0], colors[1]]
                : [Colors.redAccent, const Color(0xFF0F1923)],
          ),
        ),
        child: Stack(
          children: [
            // عکس بزرگ ایجنت (Full Portrait)
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: CachedNetworkImage(
                imageUrl: widget.agent.fullPortrait,
                height: 450,
                fit: BoxFit.contain,
                errorWidget: (c, u, e) => const Icon(Icons.error, size: 100),
              ),
            ),

            // دکمه بازگشت و نام ایجنت
            Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Column(
                    children: [
                      Text(
                        widget.agent.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.agent.role.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  // دکمه ستاره (علاقه‌مندی‌ها)
                  BlocBuilder<AgentsBloc, AgentsState>(
                    builder: (context, state) {
                      bool isFavorite = false;
                      if (state is AgentsSuccess) {
                        isFavorite = state.favoriteIds.contains(
                          widget.agent.id,
                        );
                      }
                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.star : Icons.star_border,
                          color: isFavorite ? Colors.yellow : Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          context.read<AgentsBloc>().add(
                            ToggleFavoriteEvent(widget.agent.id, !isFavorite),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            // بخش پایین: توضیحات و توانایی‌ها
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 250,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    // لیست افقی آیکون توانایی‌ها
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.agent.abilities.length,
                        itemBuilder: (context, index) {
                          final ability = widget.agent.abilities[index];
                          final isSelected = selectedAbilityIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedAbilityIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 15),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white24,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: ability.iconUrl,
                                width: 40,
                                color: isSelected ? Colors.black : Colors.white,
                                errorWidget: (c, u, e) =>
                                    const Icon(Icons.star, color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // متن توضیحات ایجنت یا توانایی انتخاب شده
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          widget.agent.abilities.isNotEmpty
                              ? widget
                                    .agent
                                    .abilities[selectedAbilityIndex]
                                    .description
                              : widget.agent.description,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
