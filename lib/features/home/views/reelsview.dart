import 'package:flutter/material.dart';
import 'package:selivery_client/core/functions/global_function.dart';
import 'package:selivery_client/features/home/views/main_view.dart';

import '../../../controllers/reelscontroller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../core/contants/api.dart';
import '../../../core/services/cache_storage_services.dart';

class ReelScreen extends StatefulWidget {
  @override
  _ReelScreenState createState() => _ReelScreenState();
}

class _ReelScreenState extends State<ReelScreen> {
  final ReelService _reelService = ReelService();
  List<Reel> _reels = [];
  int _currentIndex = 0;
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _loadReels();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _loadReels() async {
    try {
      List<Reel> reels = await _reelService.fetchReels();
      setState(() {
        _reels = reels;
      });
      if (_reels.isNotEmpty && _controller == null) {
        _initializeVideo(_reels[_currentIndex].url!);
      }
    } catch (e) {
      print(e);
    }
  }

  void _initializeVideo(String url) {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  Future<void> _removeReel(String reelId) async {
    try {
      final response = await http.get(
          Uri.parse(removereelsapi(reelId)),
          headers: authHeadersWithToken(CacheStorageServices().token)
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to remove reel');
      }
    } catch (e) {
      print("Error removing reel: $e");
    }
  }

  Future _onReelWatched(int index) async {
    if (index < _reels.length) {
      final reelId = _reels[index].sId!;
      print("Removing reel ID: $reelId");
      try {
        // Call the API to remove the reel
        await _removeReel(reelId);
        // Update the local list to remove the reel
        setState(() {
          _reels.removeAt(index);
          if (_reels.isEmpty) {
            // Navigate to home screen if the list is empty
            WidgetsBinding.instance.addPostFrameCallback((_) {
              navigateOff(MainView());
            });
          } else {
            // Adjust the current index if needed
            if (_currentIndex >= _reels.length) {
              _currentIndex = _reels.length - 1;
            }
            // Reinitialize video player with the new current reel if any
            if (_reels.isNotEmpty) {
              _initializeVideo(_reels[_currentIndex].url!);
            }
          }
        });
      } catch (e) {
        print("Error handling watched reel: $e");
      }
    }
  }
  void _onPageChanged(int index) async {
    if (index < _reels.length) {
      await _onReelWatched(index);
    }
    if (_reels.isEmpty || index == _reels.length) {
      await _onReelWatched(index);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigateOff(MainView());
      });
    }
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: _reels.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : PageView.builder(
          itemCount:  _reels.isEmpty ? 0 : _reels.length + 1,
          // Adding 1 to navigate to home after the last reel
          scrollDirection: Axis.vertical,
          onPageChanged: _onPageChanged,
          itemBuilder: (context, index) {
            if (index >= _reels.length) {
              // Navigate to home screen after last reel
              return const Center(child: CircularProgressIndicator());
            }
            return _controller != null && index == _currentIndex
                ? YoutubePlayer(
              controller: _controller!,
              showVideoProgressIndicator: true,
              onReady: () {
                _controller!.play();
              },
            )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      );
    }
  }

