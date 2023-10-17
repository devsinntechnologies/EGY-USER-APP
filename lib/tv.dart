import 'dart:async';

import 'package:egypt_user_tv/provider/socket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'main.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  void dispose() {
    super.dispose();
  }



  @override
  void initState() {
          var provider = context.read<SocketProvider>();
        provider.connection();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        var provider = context.read<SocketProvider>();
        provider.connection();
      }),
      appBar: AppBar(
        title: const Text('Egypt_American TV'),
      ),
      body: Center(
        child: Builder(builder: (context) {
          var socketProvider = context.watch<SocketProvider>();
          return socketProvider.urls == null
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Container(
                height: 400,
                child: VideoPlayer(socketProvider.controller!));
        }),
      ),
    );
  }
}
