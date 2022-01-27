import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movieapi/constants/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class MovieTrailersScreen extends StatefulWidget {

  MovieTrailersScreen({Key? key,required this.videoID}) : super(key: key);
  final String videoID;

  @override
  State<MovieTrailersScreen> createState() => _MovieTrailersScreenState();
}

class _MovieTrailersScreenState extends State<MovieTrailersScreen> {

  late YoutubePlayerController _controller;

  @override
  void initState(){
    super.initState();
    _controller = YoutubePlayerController(initialVideoId: '${widget.videoID}', flags: YoutubePlayerFlags(autoPlay: true,));

  }
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: MyColors.red,
    );
  }
}
