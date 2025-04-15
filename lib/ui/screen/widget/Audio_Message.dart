import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioMessage extends StatefulWidget {
  final String audioPath;

  const AudioMessage({Key? key, required this.audioPath}) : super(key: key);

  @override
  _AudioMessageState createState() => _AudioMessageState();
}

class _AudioMessageState extends State<AudioMessage> {
  late AudioPlayer _player;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _togglePlayPause() async {
    if (isPlaying) {
      await _player.pause();
    } else {
      await _player.setFilePath(widget.audioPath);
      await _player.play();
    }

    setState(() {
      isPlaying = !isPlaying;
    });

    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
            color: Colors.white,
            size: 30,
          ),
          onPressed: _togglePlayPause,
        ),
        const Text("تسجيل صوتي", style: TextStyle(color: Colors.white70)),
      ],
    );
  }
}
