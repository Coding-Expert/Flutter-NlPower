import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:nlpower/model/group.dart';
import 'package:nlpower/module/daily_module.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:toast/toast.dart';

enum PlayerState { stopped, playing, paused }

class AudioWidget extends StatefulWidget {
  final Group group;
  AudioWidget({Key key, this.group}) : super(key: key);

  AudioWidgetState createState() => AudioWidgetState();
}

class AudioWidgetState extends State<AudioWidget> {
  double progress_value = 80;
  PlayerState playerState;
  Duration duration = new Duration();
  Duration position = new Duration();
  AudioCache audioCache;
  AudioPlayer advancedPlayer;
  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  @override
  initState() {
    super.initState();
    initPlayer();
  }

  initPlayer() async {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);
    playerState = PlayerState.playing;
    setState(() {
      if (playerState != PlayerState.stopped) {
        // stop();
      }
      // play();
    });

    advancedPlayer.durationHandler = (d) => setState((){
      duration = d;
    });

    advancedPlayer.positionHandler = (p) => setState(() {
      position = p;
    });
    advancedPlayer.completionHandler = () {
      onComplete();
      setState(() {
        position = duration;
      });
    };
  }

  void onComplete() {
    // print("The End");
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.group.item_details.photo),
              fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                pause();
                Navigator.pop(context);
              },
              icon: new Icon(
                Icons.cancel,
                color: Colors.white,
                size: 30,
              ),
            ),
          )),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Colors.white,
                      border: Border.all(width: 3.0, color: Colors.white)),
                  child: Container(
                      child: Align(
                    alignment: Alignment.center,
                    child: Text('0 / 6',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  )),
                ),
                Text('PQ Reps',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text(widget.group.item_details.title,style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 18)),
                SizedBox(
                  height: 10,
                ),
                Text(widget.group.item_details.descr,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 200,
                      child: RaisedButton(
                        onPressed: isPlaying == false ?
                        () {
                          DailyModule.setTracking(widget.group.day_id, widget.group.media_id, widget.group.item_details.duration).then((value) {
                            if(value == "success"){
                              Toast.show("Tracking is success", context);
                            }
                          });
                        }: null,
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(fontSize: 18),
                        ),
                        textColor: Colors.black,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          // side: BorderSide(color:Colors.grey.shade600)
                        ),
                        elevation: 0,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                            child: Container(
                                width: 30,
                                height: 30,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      "assets/redo.png",
                                      fit: BoxFit.fill,
                                      color: Colors.white,
                                    ),
                                    Align(
                                        alignment: Alignment.center,
                                        child: Text('10',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)))
                                  ],
                                ))),
                        SizedBox(
                          width: 20,
                        ),
                        isPlaying
                            ? Container(
                                child: IconButton(
                                  onPressed: () {
                                    play();
                                  },
                                  icon: new Icon(Icons.play_circle_filled,
                                      size: 50, color: Colors.black),
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  pause();
                                },
                                icon: new Icon(Icons.pause,
                                    size: 50, color: Colors.black),
                              ),
                        SizedBox(
                          width: 20,
                        ),
                        ClipOval(
                            child: Container(
                          width: 30,
                          height: 30,
                          child: Stack(children: [
                            Image.asset(
                              "assets/undo.png",
                              width: 30,
                              height: 30,
                              fit: BoxFit.fill,
                              color: Colors.white,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Text('10',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)))
                          ]),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Slider(
                          activeColor: Colors.white,
                          inactiveColor: Colors.white.withOpacity(0.3),
                          value: position?.inMilliseconds?.toDouble() ?? 0,
                          min: 0.0,
                          max: duration.inMilliseconds.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              seekToSecond(value);
                              value = value;
                            });
                          })),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('00:00', style: TextStyle(color: Colors.white)),
                        Text('02:13', style: TextStyle(color: Colors.white))
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    ));
  }

  void play() async {
    int result = await advancedPlayer.play("https://app.metamathesis.edu.gr/" +
        widget.group.item_details.media); // play for remote file
    // audioCache.play('audio.mp3');    // play for assets
    if (result == 1) {
      setState(() {
        playerState = PlayerState.paused;
      });
    }
  }

  void pause() {
    advancedPlayer.pause();
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  void seekToSecond(double milisecond) {
    Duration newDuration = Duration(seconds: (milisecond / 1000).round());
    advancedPlayer.seek(newDuration);
  }
}
