import "dart:convert";
import "dart:io";

enum AuroraDataTypes { request }

class AuroraData {
  AuroraData(this.dataFrom, this.dataType, this.dataBody);

  final String dataFrom;
  final String dataType;
  final String dataBody;

  AuroraData.fromJson(Map<String, dynamic> jsonData) : this(jsonData["dataFrom"], jsonData["dataType"], jsonData["dataBody"]);

  Map<String, dynamic> toJson() {
    return {
      "dataFrom": dataFrom,
      "dataType": dataType,
      "dataBody": dataBody,
    };
  }
}

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

  static String makeRequestData(AuroraDataTypes dataType, String dataBody) {
    return jsonEncode(AuroraData("Aurora", dataType.toString(), dataBody));
  }

  static void printAuroraData(AuroraData auroraData) {
    print("AuroraData: dataFrom = ${auroraData.dataFrom}, dataType = ${auroraData.dataType}, dataBody = ${auroraData.dataBody}");
  }

  static void decodeReceivedData(String receivedData, InternetAddress address, int port) {
    final Map<String, dynamic> jsonData = jsonDecode(receivedData);
    final AuroraData auroraData = AuroraData.fromJson(jsonData);
    printAuroraData(auroraData);

    if (auroraData.dataBody == "onSimulationStart") {
      sendData(makeRequestData(AuroraDataTypes.request, "getCampaignInitData"), address, port);
    }
  }

  static void sendData(String data, InternetAddress address, int port) {
    _server.send(utf8.encode(data), address, port);
  }

  static Future<void> quitServer() async {
    _server.close();
  }
}
