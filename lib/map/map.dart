import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:flutter/material.dart";

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  final LatLng _coord = LatLng(41.841944 - 0.0015, 41.797778 + 0.001775);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        zoom: 13.0,
        minZoom: 9.0,
        maxZoom: 17.0,
        center: _coord,
        keepAlive: true,
        scrollWheelVelocity: 0.075,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://api.mapbox.com/styles/v1/kimahri/clbar27gz000114rvb0c31n74/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2ltYWhyaSIsImEiOiJjbGJhbXo2aXEwYWo3M29wYmF0ajJrNGxkIn0.ZH3goD9qaf3RnvYQtdclcQ",
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: _coord,
              builder: (context) => const Icon(
                Icons.my_location,
                color: Colors.black,
              ),
            )
          ],
        )
      ],
    );
  }
}
