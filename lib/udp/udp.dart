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

  static void decodeReceivedData(String receivedData, InternetAddress address, int port) {
    print(receivedData);
    final Map<String, dynamic> jsonData = jsonDecode(receivedData);
    print(jsonData);
    // if (receivedData == "Aurora: onSimulationStart") {
    //   sendData("getPlayerCoordinate", address, port);
    // }
  }

  static void sendData(String data, InternetAddress address, int port) {
    _server.send(utf8.encode(data), address, port);
  }

  static Future<void> quitServer() async {
    _server.close();
  }
}
