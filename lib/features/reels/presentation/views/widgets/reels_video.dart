import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../controller/reels_cubit/reels_cubit.dart';

class ReelsVideoWidget extends StatefulWidget {
  const ReelsVideoWidget({
    super.key,
    required this.videoID,
    required this.onVideoEnd,
    required this.cubit, required this.ID,
  });

  final String videoID;
  final String ID;
  final ReelsCubit cubit;
  final VoidCallback onVideoEnd;

  @override
  State<ReelsVideoWidget> createState() => _ReelsVideoWidgetState();
}

class _ReelsVideoWidgetState extends State<ReelsVideoWidget> {
  late YoutubePlayerController _controller;

  String? extractVideoId(String url) {
    final RegExp regExp = RegExp(r'\/shorts\/([a-zA-Z0-9_-]+)');
    final match = regExp.firstMatch(url);

    if (match != null && match.groupCount > 0) {
      return match.group(1);
    }
    return null; // Return null if no match is found
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: extractVideoId(widget.videoID) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        showLiveFullscreenButton: false,
        mute: false,
      ),
    );

    // Listen for player state changes
    _controller.addListener(() {
      if (_controller.value.isReady) {
        //widget.cubit.removeReels(videoId: widget.ID);
        final playerState = _controller.value.playerState;
        if (playerState == PlayerState.ended) {
          widget.onVideoEnd();
          widget.cubit.removeReels(videoId: widget.ID);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        onReady: () {
          print('Player is ready.');
        },
      ),
      builder: (context, player) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: player,
        );
      },
    );
  }
}
