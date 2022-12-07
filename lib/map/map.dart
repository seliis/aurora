import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_map/flutter_map.dart";
import "package:aurora/map/marker.dart";
import "package:latlong2/latlong.dart";
import "package:flutter/material.dart";

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  static final LatLng _coord = LatLng(41.841944, 41.797778);

  static final MapOptions mapOptions = MapOptions(
    zoom: 13.0,
    minZoom: 9.0,
    maxZoom: 13.0,
    center: _coord,
    keepAlive: true,
    scrollWheelVelocity: 0.075,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlutterMap(
      options: mapOptions,
      children: [
        TileLayer(
          urlTemplate: "https://api.mapbox.com/styles/v1/kimahri/clbar27gz000114rvb0c31n74/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2ltYWhyaSIsImEiOiJjbGJhbXo2aXEwYWo3M29wYmF0ajJrNGxkIn0.ZH3goD9qaf3RnvYQtdclcQ",
        ),
        MarkerLayer(
          markers: ref.watch(AuroraMarker.markersProvider),
        )
      ],
    );
  }
}
