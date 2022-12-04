import "dart:convert";
import "dart:io";

class AuroraDataFormat {
  AuroraDataFormat(this.dataFrom, this.dataType, this.dataBody);

  final String dataFrom;
  final String dataType;
  final String dataBody;

  AuroraDataFormat.fromJson(Map<String, dynamic> jsonData) : this(jsonData["dataFrom"], jsonData["dataType"], jsonData["dataBody"]);

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

  static void decodeReceivedData(String receivedData, InternetAddress address, int port) {
    final Map<String, dynamic> jsonData = jsonDecode(receivedData);
    final AuroraDataFormat auroraData = AuroraDataFormat.fromJson(jsonData);
    print(auroraData.dataFrom);
    print(auroraData.dataType);
    print(auroraData.dataBody);
    if (auroraData.dataBody == "onSimulationStart") {
      final AuroraDataFormat requestData = AuroraDataFormat("Aurora", "Request", "testFunc");
      sendData(jsonEncode(requestData), address, port);
    }
  }

  static void sendData(String data, InternetAddress address, int port) {
    _server.send(utf8.encode(data), address, port);
  }

  static Future<void> quitServer() async {
    _server.close();
  }
}
