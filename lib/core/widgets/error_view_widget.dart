import 'package:flutter/material.dart';

class ErrorViewWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorViewWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 48),
            Text(message),
            ElevatedButton.icon(
              onPressed: () {
                onRetry(); // اجرای دکمه ت
              },
              label: Text('تلاش مجدد'),
            ),
            SizedBox(height: 16),

            // ۱. آیکون wifi_off
            // ۲. متن بزرگ 'اوه! یه مشکلی پیش اومد'
            // ۳. نمایش متغیر message
            // ۴. دکمه ElevatedButton.icon که onPressed اون برابر با onRetry هست.
          ],
        ),
      ),
    );
  }
}
