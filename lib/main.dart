import 'dart:developer';

import 'package:egypt_user_tv/provider/socket_provider.dart';
import 'package:egypt_user_tv/splash.dart';
import 'package:egypt_user_tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // connectionWebSocket();
  connection();
  runApp(MyApp());
}

String idAdress = "192.168.10.13";

connectionWebSocket() {
  final wsUrl = Uri.parse('ws://' + idAdress + ':5000');
  var channel = WebSocketChannel.connect(wsUrl);

  channel.stream.listen((message) {
    channel.sink.add('received!');
    channel.sink.close(status.goingAway);
  });
}

connection() {
  IO.Socket socket = IO.io('http://192.168.10.13:5000');
  socket.onConnect((_) {
    print('connect');
  });
  socket.on('video_links', (data) {
    print(data);
    //  LinksModel urlData =  LinksModel.fromJson(data);
    //   urls = urlData;
    //   notifyListeners();
  });
  socket.onDisconnect((_) => print('disconnect'));

  // var socket = IO.io("http://" + idAdress + ":5000", <String, dynamic>{
  //   // "transports": ["websocket"],
  //   "autoConnect": true,
  // });
  // debugger();
  // socket.connect();
  // socket.onConnect((data) => print("Connected"));
  // socket.onReconnectError(
  //     (data) => print(data.toString() + "==================!"));

  // socket
  //     .onConnectError((data) => print(data.toString() + "==================+"));
  // print(socket.connected);
  // socket.onError((e) => print(e.toString() + "==================="));
  // socket.onDisconnect((_) => print('disconnect'));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SocketProvider()),
      ],
      child: MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
