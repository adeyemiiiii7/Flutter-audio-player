import 'package:audio_player/models/position_dart.dart';
import 'package:audio_player/widgets/controls.dart';
import 'package:audio_player/widgets/media_meta.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;

   final _playlist = ConcatenatingAudioSource(
    children: [
      AudioSource.asset(
        'assets/audio/Davidofall.mp3',
        tag: MediaItem(
          id: '0',
           title: 'Fall',
           artist: 'Davido',
            artUri: Uri.parse('https://linkstorage.linkfire.com/medialinks/images/c8f2c83c-ccdb-472c-b811-541dc1cb23e6/artwork-600x315.jpg'
      ),
        ),
      ),
      AudioSource.asset(
        'assets/audio/Burnaboyitsplenty.mp3',
         tag: MediaItem(
          id: '1',
           title: "It's Plenty",
           artist: 'Burna Boy',
            artUri: Uri.parse('https://tooxclusive.com/wp-content/uploads/2022/08/Screenshot-2022-08-10-at-11.53.41.png'
      ),
        ),
      ),
    ],
   );



  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _init();
    // ..setAsset('assets/audio/Davidofall.mp3');
   // ..setUrl('https://www.podcasts-online.org/bbc-music-introducing-mixtape-269455899');
  }



   Future<void> _init() async{
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(_playlist);
   }
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_outlined),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF144771), Color(0xFF071A2C)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(stream: _audioPlayer.sequenceStateStream, 
            builder: (context, snapshot){
            final state = snapshot.data;
            if(state?.sequence.isEmpty ?? true){
            return const SizedBox();
            }
            final metadata = state!.currentSource!. tag as MediaItem;
            return MediaMetadata(imageUrl: metadata.artUri.toString(), 
            title: metadata.title, 
            artist: metadata.artist ?? '',);
            }
            ),
            const SizedBox(height: 20),
            StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return ProgressBar(
                barHeight: 8,
                baseBarColor: Colors.grey[600],
                bufferedBarColor: Colors.grey,
                progressBarColor: Colors.blueGrey,
                thumbColor: Colors.blueAccent,
                timeLabelTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600
                ),
                  progress: positionData?.position ?? Duration.zero,
                  buffered: positionData?.bufferedPosition ?? Duration.zero,
                  total: positionData?.duration ?? Duration.zero,
                  onSeek: _audioPlayer.seek,
                );
              },
            ),
            const SizedBox(height: 20),
            Controls(audioPlayer: _audioPlayer),
          ],
        ),
      ),
    );
  }
}
