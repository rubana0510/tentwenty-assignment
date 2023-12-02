import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String videoId;

  VideoScreen({required this.videoId});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:
          widget.videoId, // Replace with the actual YouTube video ID
      flags: YoutubePlayerFlags(
        autoPlay: true,
        enableCaption: false,
        isLive: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: YoutubePlayer(
              controller: _controller,
              onEnded: (data) {
                Navigator.pop(context); // Pop the screen when the video ends
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Container(
              width: 120,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Done",
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
