class ValorantMap {
  final String id;
  final String name;
  final String imageUrl;
  final String splashUrl;
  final String tacticalMapUrl; // ✅ نقشه تاکتیکی
  final List<String> callouts; // ✅ نقاط استراتژیک

  const ValorantMap({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.splashUrl,
    required this.tacticalMapUrl,
    required this.callouts,
  });
}
