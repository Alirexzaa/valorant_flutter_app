import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:new_block/features/weapons/domain/entities/weapon.dart';

class WeaponDetailsPage extends StatefulWidget {
  final Weapon weapon;
  const WeaponDetailsPage({super.key, required this.weapon});

  @override
  State<WeaponDetailsPage> createState() => _WeaponDetailsPageState();
}

class _WeaponDetailsPageState extends State<WeaponDetailsPage> {
  late WeaponSkin selectedSkin;

  @override
  void initState() {
    super.initState();
    // انتخاب اسکین اول به صورت پیش‌فرض
    if (widget.weapon.skins.isNotEmpty) {
      selectedSkin = widget.weapon.skins.first;
    } else {
      // اگه اسکینی نبود (احتمال کم)، خود سلاح رو پیش‌فرض می‌ذاریم
      selectedSkin = WeaponSkin(
        name: widget.weapon.name,
        displayIcon: widget.weapon.imageUrl,
        videoUrl: null,
      );
    }
  }

  // تابع باز کردن ویدیو
  void _playVideo(String? videoUrl) async {
    if (videoUrl == null || videoUrl.isEmpty) return;
    final url = Uri.parse(videoUrl);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('خطا در باز کردن ویدیو')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1923),
      appBar: AppBar(
        title: Text(
          widget.weapon.name,
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
            // ═══════════════════════════════════════════
            // ۱. عکس اسکین انتخاب شده (با انیمیشن تغییر)
            // ═══════════════════════════════════════════
            Container(
              width: double.infinity,
              height: 250,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey[900]!, const Color(0xFF0F1923)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              // ✅ استفاده از AnimatedSwitcher برای تغییر نرم و محو شدن عکس
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: CachedNetworkImage(
                  key: ValueKey(
                    selectedSkin.displayIcon,
                  ), // کلید یکتا برای تشخیص تغییر
                  imageUrl: selectedSkin.displayIcon,
                  fit: BoxFit.contain,
                  errorWidget: (c, u, e) => const Icon(Icons.error, size: 50),
                ),
              ),
            ),

            // ═══════════════════════════════════════════
            // ۲. اطلاعات اسکین انتخاب شده و دکمه پلی
            // ═══════════════════════════════════════════
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // نام اسکین انتخاب شده
                  Text(
                    selectedSkin.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ✅ دکمه پخش ویدیو (فقط اگر ویدیو داشته باشد)
                  if (selectedSkin.videoUrl != null &&
                      selectedSkin.videoUrl!.isNotEmpty)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => _playVideo(selectedSkin.videoUrl),
                        icon: const Icon(
                          Icons.play_circle_fill,
                          color: Colors.white,
                          size: 28,
                        ),
                        label: const Text(
                          'پخش ویدیوی اسکین',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  const Divider(color: Colors.white24, height: 40),

                  const Text(
                    'گالری اسکین‌ها',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),

            // ═══════════════════════════════════════════
            // ۳. لیست اسکین‌ها
            // ═══════════════════════════════════════════
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              itemCount: widget.weapon.skins.length,
              itemBuilder: (context, index) {
                final skin = widget.weapon.skins[index];
                final isSelected =
                    selectedSkin.name ==
                    skin.name; // چک میکنیم این اسکین انتخاب شده یا نه
                final hasVideo =
                    skin.videoUrl != null && skin.videoUrl!.isNotEmpty;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSkin =
                          skin; // ✅ با کلیک، اسکین انتخاب شده عوض میشه
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.redAccent.withValues(alpha: 0.1)
                          : Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? Colors
                                  .redAccent // اگه انتخاب شده، کادرش قرمزه
                            : (hasVideo ? Colors.white24 : Colors.transparent),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      leading: Container(
                        width: 100,
                        height: 60,
                        padding: const EdgeInsets.all(4),
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
                      title: Text(
                        skin.name,
                        style: TextStyle(
                          color: isSelected ? Colors.redAccent : Colors.white,
                          fontSize: 16,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),

                      trailing: hasVideo
                          ? const Icon(
                              Icons.play_circle_outline,
                              color: Colors.redAccent,
                              size: 28,
                            )
                          : null,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
