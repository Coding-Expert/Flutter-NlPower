import 'dart:async';
import 'dart:ui';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class GymAudioWidget extends StatefulWidget {
  final String mediaURL;
  final String duration;
  final String title;
  GymAudioWidget({this.mediaURL, this.duration, this.title, Key key})
      : super(key: key);
  GymAudioWidgetState createState() => GymAudioWidgetState();
}

class GymAudioWidgetState extends State<GymAudioWidget> {
  bool isLoading = false;
  bool isPlaying = false;
  bool isCompleted = false;
  bool isShowSuccess = false;
  AudioCache audioCache;
  AudioPlayer audioPlayer;
  double _sliderValue = 0;
  Duration currentTime;
  Duration totalTime = Duration(minutes: 1, seconds: 15);
  Timer _timer;
  int duration = 5;

  Duration _getDuration(double sliderValue) {
    final seconds = totalTime.inSeconds * sliderValue;
    return Duration(seconds: seconds.toInt());
  }

  String _getTimeString(double sliderValue) {
    final time = _getDuration(sliderValue);
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    final minutes =
        twoDigits(time.inMinutes.remainder(Duration.minutesPerHour));
    final seconds =
        twoDigits(time.inSeconds.remainder(Duration.secondsPerMinute));

    final hours = totalTime.inHours > 0 ? '${time.inHours}:' : '';
    return "$hours$minutes:$seconds";
  }

  _setSliderValue(Duration current) {
    final seconds = current.inSeconds;
    setState(() {
      _sliderValue = seconds * 1.0 / totalTime.inSeconds;
    });
  }

  Future<void> _init() async {
    // Try to load audio from a source and catch any errors.
    try {
      audioPlayer = new AudioPlayer();
      audioCache = new AudioCache(fixedPlayer: audioPlayer);
      await audioPlayer
          .setUrl("https://app.metamathesis.edu.gr/" + widget.mediaURL);
      audioPlayer.durationHandler = (d) => setState(() {
        setState(() {
          isLoading = false;
          totalTime = d;
        });
      });
      audioPlayer.positionHandler = (p) => setState(() {
        setState(() {
          currentTime = p;
          _setSliderValue(currentTime);
        });
      });
      audioPlayer.completionHandler = () {
        _setSliderValue(Duration.zero);
        setState(() {
          isPlaying = false;
          isCompleted = true;
          audioPlayer.release();
        });
      };
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (duration == 0) {
          audioPlayer.release();
          _timer.cancel();
          Navigator.pop(context);
        } else {
          setState(() {
            duration--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    audioPlayer.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      startTimer();
      setState(() {
        isCompleted = false;
        isShowSuccess = true;
      });
    }
    if (isShowSuccess) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/congratulation.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      );
    }
    return !isLoading
        ? Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.close_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 5,
                          color: Colors.white,
                        ),
                        shape: BoxShape.circle,
                      ),
                      width: 80,
                      height: 80,
                      child: Center(
                        child: Text(
                          "0/15",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "PQ Reps",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "GYM",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${widget.duration}min • ${widget.title}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(color: Colors.black26),
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(255, 255, 255, 200)),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(
                            horizontal: 50,
                          ),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.history,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: () {
                            final currentValue =
                                _sliderValue - 10.0 / totalTime.inSeconds;
                            Duration currentDuration =
                                _getDuration(currentValue);
                            if (currentDuration.compareTo(Duration.zero) < 0)
                              currentDuration = Duration.zero;
                            audioPlayer.seek(currentDuration);
                            _setSliderValue(currentDuration);
                          },
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(50),
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                          child: IconButton(
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 40,
                            ),
                            onPressed: () {
                              setState(() {
                                isPlaying = !isPlaying;
                                isPlaying
                                    ? audioPlayer.resume()
                                    : audioPlayer.pause();
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.update,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: () {
                            final currentValue =
                                _sliderValue + 10.0 / totalTime.inSeconds;
                            Duration currentDuration =
                                _getDuration(currentValue);
                            if (totalTime.compareTo(currentDuration) < 0)
                              currentDuration = totalTime;
                            audioPlayer.seek(currentDuration);
                            _setSliderValue(currentDuration);
                          },
                        ),
                      ],
                    ),
                    Slider(
                      value: _sliderValue,
                      activeColor: Colors.white,
                      inactiveColor: Theme.of(context).disabledColor,
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                          audioPlayer.seek(_getDuration(_sliderValue));
                        });
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _getTimeString(_sliderValue),
                            style: TextStyle(
                              fontFeatures: [FontFeature.tabularFigures()],
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            isLoading ? "--:--:--" : _getTimeString(1),
                            style: TextStyle(
                              fontFeatures: [FontFeature.tabularFigures()],
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
