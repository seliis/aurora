import "package:aurora/model/model.dart";
import "package:aurora/map/marker.dart";
import "dart:convert";
import "dart:io";

class UDP {
  static final _instance = UDP._singleInstance();
  factory UDP() => _instance;
  UDP._singleInstance();

  static late RawDatagramSocket _server;

  static Future<void> initServer() async {
    _server = await RawDatagramSocket.bind("127.0.0.1", 3000);
    _server.listen((RawSocketEvent event) {
      Datagram? datagram = _server.receive();

      if (datagram != null) {
        String receivedData = String.fromCharCodes(datagram.data);
        decodeReceivedData(receivedData, datagram.address, datagram.port);
      }
    });
  }

  static String makeRequestData(AuroraDataTypes dataType, Map<String, dynamic> dataBody) {
    return jsonEncode(AuroraData("AURORA_APP", dataType.name, dataBody));
  }

  static void printAuroraData(AuroraData auroraData) {
    print("AuroraData: dataFrom = ${auroraData.dataFrom}, dataType = ${auroraData.dataType}, dataBody = ${auroraData.dataBody}");
  }

  static void decodeReceivedData(String receivedData, InternetAddress address, int port) {
    final AuroraData auroraData = AuroraData.fromJson(jsonDecode(receivedData));
    // printAuroraData(auroraData);

    if (auroraData.dataType == AuroraDataTypes.event.name) {
      if (auroraData.dataBody["eventName"] == "onSimulationStart") {
        sendData(
          makeRequestData(AuroraDataTypes.request, {
            "targetFunction": "getCampaignInitData"
          }),
          address,
          port,
        );
        return;
      }
    }

    if (auroraData.dataType == AuroraDataTypes.notice.name) {
      final AuroraNoticeData auroraNoticeData = AuroraNoticeData.fromJson(auroraData.dataBody);
      print(auroraNoticeData.content);
      return;
    }

    if (auroraData.dataType == AuroraDataTypes.zone.name) {
      final AuroraZoneData auroraZoneData = AuroraZoneData.fromJson(auroraData.dataBody);
      AuroraMarker.markers.add(AuroraMarker.makeMarker(auroraZoneData.latitude, auroraZoneData.longitude));
      print(auroraZoneData.name);
      return;
    }
  }

  static void sendData(String data, InternetAddress address, int port) {
    _server.send(utf8.encode(data), address, port);
  }

  static Future<void> quitServer() async {
    _server.close();
  }
}
