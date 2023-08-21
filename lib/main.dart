import 'package:audio_player/screens/audio_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
     title: 'Flutter Audio Player',
     debugShowCheckedModeBanner: false,
     theme: ThemeData(
      primarySwatch: Colors.blue),
      home: const AudioPlayerScreen()
     
    );
  }
}
