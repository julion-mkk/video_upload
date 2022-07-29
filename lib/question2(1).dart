import 'dart:async';
import 'dart:io';
import 'dart:isolate';

void main() async {
  ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(_downloadAndCompressTheInternet, receivePort.sendPort);
  receivePort.listen((message) {
    stdout.write(message);
  });
}

Future<void> _downloadAndCompressTheInternet(SendPort sendPort) async {
  int count = 0;
  Timer(const Duration(seconds: 2), () {
    for(int i=0;i<42;i++) {
      count++;
    }
    sendPort.send(count);
  });
}


