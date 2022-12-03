import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:flutter/material.dart";

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  final LatLng _coord = LatLng(41.616773896795, 41.589899347048);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        //crs: const Epsg4326(),
        center: _coord,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: "com.example.app",
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: _coord,
              builder: (context) => const FlutterLogo(),
            )
          ],
        )
      ],
    );
  }
}
