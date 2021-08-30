import 'package:flutter/material.dart';
import 'package:nlpower/widget/_audio_widget.dart';

class AudioCard extends StatefulWidget {
  final String photoURL;
  final String duration;
  final String mediaURL;
  final String title;
  AudioCard({this.photoURL, this.duration, this.mediaURL, this.title, Key key})
      : super(key: key);

  @override
  _AudioCardState createState() => _AudioCardState();
}

class _AudioCardState extends State<AudioCard> {
  @override
  void initState() {
    super.initState();
  }

  _showSimpleModalDialog(context) => {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              insetPadding: EdgeInsets.all(0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.photoURL),
                    fit: BoxFit.cover,
                  ),
                ),
                child: GymAudioWidget(
                  mediaURL: widget.mediaURL,
                  duration: widget.duration,
                  title: widget.title,
                ),
              ),
            );
          },
        ),
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 3,
      margin: EdgeInsets.only(
        right: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: NetworkImage(widget.photoURL), fit: BoxFit.cover)),
      child: Center(
        child: GestureDetector(
          onTap: () => {_showSimpleModalDialog(context)},
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(200),
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 40,
                ),
                Text(
                  widget.duration + " mins",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
