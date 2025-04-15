import 'package:artificial/assets.dart';
import 'package:artificial/ui/Tap/Chat/Video_Message%20.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatTap extends StatefulWidget {
  final String workerName;
  final String workerImage;

  const ChatTap({
    Key? key,
    required this.workerName,
    required this.workerImage,
  }) : super(key: key);

  @override
  _ChatTapState createState() => _ChatTapState();
}

class _ChatTapState extends State<ChatTap> {
  final ImagePicker _picker = ImagePicker();
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();

  Timer? _recordTimer;
  int _recordDuration = 0;

  List<Map<String, String>> chatList = [];

  Map<String, List<Map<String, String>>> messages = {};

  late String selectedChat;

  TextEditingController messageController = TextEditingController();

  bool isRecording = false;
  String? _currentlyPlayingPath;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    selectedChat = widget.workerName;

    // إضافة المحادثة لو مش موجودة
    chatList.add({
      "name": widget.workerName,
      "message": "",
      "image": widget.workerImage,
    });
    messages[selectedChat] = [];
  }

  void sendMessage(String message) {
    if (message.trim().isEmpty) return;
    setState(() {
      messages[selectedChat]?.add({"text": message, "isMe": "true"});
    });
    messageController.clear();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        messages[selectedChat]?.add({
          "text": pickedFile.path,
          "isMe": "true",
          "isImage": "true",
        });
      });
    }
  }

  Future<void> _pickVideo(ImageSource source) async {
    final pickedFile = await _picker.pickVideo(source: source);
    if (pickedFile != null) {
      setState(() {
        messages[selectedChat]?.add({
          "text": pickedFile.path,
          "isMe": "true",
          "isVideo": "true",
        });
      });
    }
  }

  void _startTimer() {
    _recordDuration = 0;
    _recordTimer = Timer.periodic(Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => _recordDuration++);
      }
    });
  }

  void _stopTimer() {
    _recordTimer?.cancel();
    _recordTimer = null;
  }

  Future<void> _startRecording() async {
    final hasPermission = await _audioRecorder.hasPermission();
    if (hasPermission) {
      final dir = await getTemporaryDirectory();
      final path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _audioRecorder.start(const RecordConfig(), path: path);
      _startTimer();
      setState(() => isRecording = true);
    }
  }

  Future<void> _stopRecording() async {
    final path = await _audioRecorder.stop();
    _stopTimer();
    setState(() => isRecording = false);

    if (path != null && selectedChat.isNotEmpty) {
      final file = File(path);
      if (await file.exists()) {
        setState(() {
          messages[selectedChat]?.add({
            "text": path,
            "isMe": "true",
            "isAudio": "true",
          });
        });
      }
    }
  }

  void _togglePlayPause(String path) async {
    if (_currentlyPlayingPath != path) {
      await _player.setFilePath(path);
      _currentlyPlayingPath = path;
      await _player.play();
      setState(() => _isPlaying = true);
    } else {
      if (_player.playing) {
        await _player.pause();
        setState(() => _isPlaying = false);
      } else {
        await _player.play();
        setState(() => _isPlaying = true);
      }
    }

    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (mounted) {
          setState(() {
            _isPlaying = false;
            _currentlyPlayingPath = null;
          });
        }
      }
    });
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(15),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(AppLocalizations.of(context)!.open_the_camera),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: Text(
                  AppLocalizations.of(context)!.selection_from_the_gallery),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: Text(AppLocalizations.of(context)!.video_recording),
              onTap: () {
                Navigator.pop(context);
                _pickVideo(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: Text(
                  AppLocalizations.of(context)!.selecting_a_video_from_files),
              onTap: () {
                Navigator.pop(context);
                _pickVideo(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stopTimer();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double chatWidth = constraints.maxWidth * 0.25;
        double avatarRadius = constraints.maxWidth * 0.05;
        double fontSize = constraints.maxWidth * 0.03;

        return Scaffold(
          backgroundColor: const Color(0xFF121212),
          body: Row(
            children: [
              Container(
                width: chatWidth,
                color: Colors.black,
                child: ListView(
                  children: chatList.map((chat) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedChat = chat["name"]!;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: avatarRadius,
                              backgroundImage: AssetImage(chat["image"]!),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              chat["name"]!,
                              style: TextStyle(
                                color: selectedChat == chat["name"]
                                    ? Colors.yellow
                                    : Colors.white,
                                fontSize: fontSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      color: Colors.white10,
                      child: Text(
                        selectedChat,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize * 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: messages[selectedChat]?.map((msg) {
                              if (msg["isImage"] == "true") {
                                return Image.file(File(msg["text"]!),
                                    width: 150, height: 150);
                              } else if (msg["isVideo"] == "true") {
                                return VideoMessage(videoPath: msg["text"]!);
                              } else if (msg["isAudio"] == "true") {
                                final isCurrent =
                                    _currentlyPlayingPath == msg["text"];
                                final isPlayingNow = isCurrent && _isPlaying;

                                return Align(
                                  alignment: msg["isMe"] == "true"
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryGold
                                          .withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: AppColors.primaryGold,
                                          width: 1.5),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.mic,
                                            color: isPlayingNow
                                                ? Colors.greenAccent
                                                : Colors.white),
                                        const SizedBox(width: 12),
                                        Text(
                                          isPlayingNow
                                              ? "جاري التشغيل..."
                                              : "رسالة صوتية",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(width: 10),
                                        IconButton(
                                          icon: Icon(
                                            isPlayingNow
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            color: Colors.white,
                                          ),
                                          onPressed: () =>
                                              _togglePlayPause(msg["text"]!),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Align(
                                  alignment: msg["isMe"] == "true"
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Text(
                                      msg["text"]!,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              }
                            }).toList() ??
                            [],
                      ),
                    ),
                    if (isRecording)
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.fiber_manual_record, color: Colors.red),
                            const SizedBox(width: 8),
                            Text(
                              "${AppLocalizations.of(context)!.register} ${_recordDuration}s",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (!isRecording) {
                                await _startRecording();
                              } else {
                                await _stopRecording();
                              }
                            },
                            child: Icon(
                              isRecording ? Icons.stop : Icons.mic,
                              color: AppColors.primaryGold,
                              size: 28,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white10,
                                hintText: AppLocalizations.of(context)!
                                    .write_your_message_here,
                                hintStyle:
                                    const TextStyle(color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.more_vert,
                                      color: Colors.white70),
                                  onPressed: _showImageOptions,
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send,
                                color: Colors.yellow, size: 28),
                            onPressed: () =>
                                sendMessage(messageController.text),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
