import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerView extends StatefulWidget {
  final String movieKey;
  TrailerView({this.movieKey});
  @override
  _TrailerViewState createState() => _TrailerViewState();
}

class _TrailerViewState extends State<TrailerView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final url = 'https://www.youtube.com/watch?v=${widget.movieKey}';
    runYoutubeVideo(url);
  }

  YoutubePlayerController _youtubeController;
  void runYoutubeVideo(url) {
    _youtubeController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url),
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: true,
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _youtubeController.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubeController,
        ),
        builder: (context, player) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black54,
              body: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.20,
                    left: 5,
                    right: 5),
                child: player,
              ),
            ),
          );
        });
  }
}
