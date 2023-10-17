import 'dart:developer';

import 'package:egypt_user_tv/provider/socket_provider.dart';
import 'package:egypt_user_tv/splash.dart';
import 'package:egypt_user_tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/status.dart' as status;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // connectionWebSocket();
  // connection();
  runApp(MyApp());
}

String idAdress = "192.168.10.13";

// connectionWebSocket() {
//   final wsUrl = Uri.parse('ws://' + idAdress + ':5000');
//   var channel = WebSocketChannel.connect(wsUrl);

//   channel.stream.listen((message) {
//     channel.sink.add('received!');
//     channel.sink.close(status.goingAway);
//   });
// }

connection() {
//   IO.Socket socket = IO.io('http://192.168.31.227:5000'
// //   , <String, dynamic>{
// //     "transports": ["websockets"],
// // }
// );
//   debugger();
  // socket.onConnect((_) {
  //   print('connect');
  // // debugger();
  // });
  // socket.on('video_links', (data) {
  //   print(data);
  //   //  LinksModel urlData =  LinksModel.fromJson(data);
  //   //   urls = urlData;
  //   //   notifyListeners();
  // });
//   socket.onDisconnect((_) => print('disconnect'));
IO.Socket socketIO;
    socketIO = IO.io("http://3.80.91.77:5000", <String, dynamic>{
      'transports': ['websocket'],
      'upgrade': false
    });
  socketIO.onConnect((_) {
    print('connect');
  // debugger();
  });

    socketIO.connect();
    socketIO.on("connect", (data) {
      print("Connection Successfully Established...");
      // onSocketConnected(socketIO);
    });
    
      socketIO.on('video_links', (data) {
    print(data);
    //  LinksModel urlData =  LinksModel.fromJson(data);
    //   urls = urlData;
    //   notifyListeners();
  });
    socketIO.on("reconnect", (data) {
      print("Socket Connected Again.. Reconnection");
    });

    socketIO.on("disconnect", (data) {
      print("Socket Disconnected Unexpectedly..");
      // onSocketDisconnected(socketIO);          
    });

     socketIO.onConnectError((data) {
      print(data);
      // onSocketDisconnected(socketIO);          
    });


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
