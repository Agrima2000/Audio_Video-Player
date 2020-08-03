import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

main() => runApp(MyHotApp());

class MyHotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return myapp();
  }
}

myapp() {
  return MaterialApp(
    home: myVideo(),
    debugShowCheckedModeBanner: false,
  );
}

// ignore: camel_case_types
class myVideo extends StatefulWidget {
  @override
  _MyVideoState createState() {
    return _MyVideoState();
  }
}

class _MyVideoState extends State<myVideo> {
  VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.asset("assets/awareness.mp4");
    _videoPlayerController.setVolume(10.0);
    _videoPlayerController.initialize();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  myCanvas() {
    var url =
        "https://api.time.com/wp-content/uploads/2018/04/listening-to-music-headphones.jpg?w=800&quality=85";

    var containerVideo = Container(
      child: Card(
        child: (_videoPlayerController != null
            ? VideoPlayer(_videoPlayerController)
            : Container()),
      ),
    );

    var containerAspect = Container(
      height: 200,
      width: 200,
      child: AspectRatio(
        aspectRatio: 16 / 9,
      ),
    );

    var playBtn = Container(
      width: 50,
      child: RaisedButton(
        color: Colors.black,
        padding: EdgeInsets.only(bottom: 6),
        onPressed: () {
          setState(() {
            if (!_videoPlayerController.value.isPlaying) {
              _videoPlayerController.play();
            }
          });
        },
        child: Icon(
          Icons.play_circle_filled,
          size: 40,
          color: Colors.white,
        ),
      ),
    );

    var pauseBtn = Container(
      width: 50,
      child: RaisedButton(
        color: Colors.black,
        padding: EdgeInsets.only(bottom: 6),
        onPressed: () {
          if (_videoPlayerController.value.isPlaying) {
            _videoPlayerController.pause();
          }
        },
        child: Icon(
          Icons.pause_circle_filled,
          size: 40,
          color: Colors.white,
        ),
      ),
    );

    var replayBtn = Container(
        width: 50,
        child: RaisedButton(
          color: Colors.black,
          padding: EdgeInsets.only(bottom: 6),
          onPressed: () {
            setState(() {
              _videoPlayerController.pause();
              _videoPlayerController =
                  VideoPlayerController.asset("assets/awareness.mp4");
              _videoPlayerController.initialize();
            });
          },
          child: Icon(
            Icons.replay,
            size: 40,
            color: Colors.white,
          ),
        ));

    var onlineBtn = Container(
        width: 50,
        child: RaisedButton(
          color: Colors.black,
          padding: EdgeInsets.only(bottom: 6),
          onPressed: () {
            setState(() {
              if (_videoPlayerController.value.isPlaying) {
                _videoPlayerController = VideoPlayerController.network(
                    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4")
                  ..initialize()
                  ..setVolume(10.0)
                  ..play();
              } else {
                _videoPlayerController = VideoPlayerController.network(
                    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4")
                  ..initialize()
                  ..setVolume(10.0)
                  ..pause();
              }
            });
          },
          child: Icon(
            Icons.ondemand_video,
            size: 40,
            color: Colors.white,
          ),
        ));

    var videoControls = Container(
      color: Colors.black,
      height: 40,
      width: double.infinity,
      margin: EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          playBtn,
          pauseBtn,
          onlineBtn,
          replayBtn,
        ],
      ),
    );

    var screenComponents = Container(
      width: 650,
      height: 250,
      alignment: Alignment.center,
      margin: EdgeInsets.all(5),
      child: Stack(
        children: <Widget>[
          containerVideo,
          containerAspect,
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 5),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    var musicPath = "audios/firestone_music.wav";
    var audioPlayers = AudioPlayer();
    var audioCache = AudioCache();
    var counter = 0;

    int flag_audio() {
      counter++;
      return counter;
    }

    var container_play = Container(
      margin: EdgeInsets.only(top: 92, left: 150),
      child: Card(
        color: Colors.pink[50].withOpacity(0),
        child: IconButton(
            icon: Icon(
              Icons.music_note,
            ),
            onPressed: () {
              var x = flag_audio();
              if (x == 1) {
                audioCache.play(musicPath);
              }
            }),
      ),
    );

    var containerImage = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 5),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.contain,
        ),
      ),
    );

    var rowAudio = Stack(
      children: <Widget>[
        containerImage,
        container_play,
      ],
    );

    var audioComponents = Container(
      width: double.infinity,
      height: 243,
      margin: EdgeInsets.all(5),
      child: rowAudio,
    );

    var myContainer = Column(
      children: <Widget>[
        screenComponents,
        videoControls,
        audioComponents,
      ],
    );

    var myLayout = Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        title: Text("MEDIA PLAYER"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, size: 30),
              onPressed: () {
                launch("https://www.youtube.com/");
              }),
        ],
      ),
      body: myContainer,
    );

    return myLayout;
  }

  @override
  Widget build(BuildContext context) {
    return myCanvas();
  }
}
