import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:new_block/features/weapons/domain/entities/weapon.dart';

class WeaponDetailsPage extends StatelessWidget {
  final Weapon weapon;
  const WeaponDetailsPage({super.key, required this.weapon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1923),
      appBar: AppBar(
        title: Text(
          weapon.name,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ۱. عکس بزرگ سلاح
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.black12,
              padding: const EdgeInsets.all(20),
              child: CachedNetworkImage(
                imageUrl: weapon.imageUrl,
                fit: BoxFit.contain,
                errorWidget: (c, u, e) => const Icon(Icons.error, size: 50),
              ),
            ),

            // ۲. اطلاعات کلی
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weapon.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(
                      weapon.category,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.redAccent.withValues(alpha: 0.5),
                    side: BorderSide.none,
                  ),
                ],
              ),
            ),

            const Divider(color: Colors.white24, height: 30),

            // ۳. بخش اسکین‌ها
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'اسکین‌های موجود',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
            ),
            const SizedBox(height: 10),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // برای اینکه با کل صفحه اسکرول بشه
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              itemCount: weapon.skins.length,
              itemBuilder: (context, index) {
                final skin = weapon.skins[index];
                return Card(
                  color: Colors.grey[900],
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Colors.redAccent.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        // عکس اسکین
                        Container(
                          width: 100,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: skin.displayIcon,
                            fit: BoxFit.contain,
                            errorWidget: (c, u, e) => const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // اسم اسکین
                        Expanded(
                          child: Text(
                            skin.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // دکمه پلی ویدیو (فقط اگه ویدیو داشته باشه)
                        if (skin.videoUrl != null && skin.videoUrl!.isNotEmpty)
                          IconButton(
                            icon: const Icon(
                              Icons.play_circle_fill,
                              color: Colors.redAccent,
                              size: 40,
                            ),
                            onPressed: () async {
                              final url = Uri.parse(skin.videoUrl!);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'امکان باز کردن ویدیو وجود ندارد',
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40), // فاصله انتهای صفحه
          ],
        ),
      ),
    );
  }
}
