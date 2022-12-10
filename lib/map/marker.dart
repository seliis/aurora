import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:flutter/material.dart";

class AuroraMarker extends StatefulWidget {
  const AuroraMarker({super.key});
  
  @override
  AuroraMarkerState createState() => AuroraMarkerState();
}

class AuroraMarkerState extends State<AuroraMarker> {
  bool isTapped = false;

  dynamic getName() {
    if (isTapped) {
      return const Positioned(
        height: 64,
        child: Text(
          "MarkerName",
          style: TextStyle(
            color: Colors.black
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Stack getMarker() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        getName(),
        InkWell(
          child: Icon(
            Icons.my_location,
            color: (isTapped) ? Colors.red : Colors.black,
          ),
          onTap: () {
            setState(() {
              isTapped = !isTapped;
            });
          }
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return getMarker();
  }
}

class AuroraMarkerList extends StateNotifier<List<Marker>> {
  static final _instance = AuroraMarkerList._singleInstance();
  AuroraMarkerList._singleInstance() : super(markerList);
  factory AuroraMarkerList() => _instance;

  static final List<Marker> markerList = [
    Marker(
      width: 256.0,
      height: 256.0,
      point: LatLng(41.841944, 41.797778),
      builder: (context) => const AuroraMarker(),
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

  static final provider = StateNotifierProvider<AuroraMarkerList, List<Marker>>((ref) => AuroraMarkerList());
}
