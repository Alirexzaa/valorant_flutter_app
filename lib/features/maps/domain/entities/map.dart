class ValorantMap {
  final String id;
  final String name;
  final String imageUrl;
  final String splashUrl;
  final String tacticalMapUrl;
  final String coordinates; // ✅ مختصات جغرافیایی
  final List<MapCallout> callouts;

  const ValorantMap({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.splashUrl,
    required this.tacticalMapUrl,
    required this.coordinates, // ✅ اضافه شد
    required this.callouts,
  });
}

class MapCallout {
  final String name;
  const MapCallout({required this.name});
}
