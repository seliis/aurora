import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:flutter/material.dart";

class AuroraMarker {
  static final _instance = AuroraMarker._singleInstance();
  factory AuroraMarker() => _instance;
  AuroraMarker._singleInstance();

  static final List<Marker> markers = [
    Marker(
      point: LatLng(41.841944, 41.797778),
      builder: (context) => const Icon(
        Icons.my_location,
        color: Colors.black,
      ),
    ),
  ];

  static Marker makeMarker(double latitude, double longitude) {
    return Marker(
      point: LatLng(latitude, longitude),
      builder: (context) => const Icon(
        Icons.my_location,
        color: Colors.red,
      ),
    );
  }

  static final markersProvider = StateProvider((ref) => markers);
}
