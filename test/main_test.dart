// ignore_for_file: avoid_print
import "dart:convert";
import "dart:io";

void main() async {
  final udp = await RawDatagramSocket.bind("127.0.0.1", 3000);

  udp.listen((RawSocketEvent event) {
    Datagram? datagram = udp.receive();

    if (datagram != null) {
      String data = String.fromCharCodes(datagram.data);
      print("$data from ${datagram.address}:${datagram.port}");

      if (data == "ping") {
        udp.send(utf8.encode("pong"), datagram.address, datagram.port);
        print("sent: pong");
      }
    }
  });
}
