import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:new_block/features/weapons/domain/entities/weapon.dart';

class WeaponDetailsPage extends StatelessWidget {
  final Weapon weapon;

  const WeaponDetailsPage({super.key, required this.weapon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(weapon.name),
        backgroundColor: Colors.redAccent.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(), // برگشت به عقب
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // عکس بزرگ ایجنت
            Hero(
              tag: weapon.id, // جادوی انیمیشن بین صفحات
              child: CachedNetworkImage(
                imageUrl: weapon.imageUrl,
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
              weapon.name,
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
                weapon.name,
                style: const TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'later',
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
