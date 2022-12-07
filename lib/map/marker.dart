import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:flutter/material.dart";

class AuroraMarker extends StateNotifier<List<Marker>> {
  static final _instance = AuroraMarker._singleInstance();
  AuroraMarker._singleInstance() : super(markers);
  factory AuroraMarker() => _instance;

  static final List<Marker> markers = [
    Marker(
      point: LatLng(41.841944, 41.797778),
      builder: (context) => const Icon(
        Icons.my_location,
        color: Colors.black,
      ),
    ),
  ];

  Marker _makeMarker(double latitude, double longitude) {
    return Marker(
      point: LatLng(latitude, longitude),
      builder: (context) => const Icon(
        Icons.my_location,
        color: Colors.red,
      ),
    );
  }

  void addMarker(double latitude, double longitude) {
    state = [
      ...state,
      _makeMarker(latitude, longitude)
    ];
  }

  static final markersProvider = StateNotifierProvider<AuroraMarker, List<Marker>>((ref) => AuroraMarker());
}
