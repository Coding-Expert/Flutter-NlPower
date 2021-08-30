import 'package:flutter/material.dart';
import 'package:nlpower/model/mediafile.dart';
import 'package:nlpower/widget/dashboard/goal.dart';
import 'package:nlpower/widget/video_widget.dart';

import '../_audio_widget.dart';

class WeeklyDetailWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<MediaFile> files;
  final String time;
  const WeeklyDetailWidget(
      {this.title, this.description, this.files, this.time, Key key})
      : super(key: key);

  @override
  _WeeklyDetailWidgetState createState() => _WeeklyDetailWidgetState();
}

class _WeeklyDetailWidgetState extends State<WeeklyDetailWidget> {
  _showAudioDialog(context, title, photoUrl, mediaUrl, duration) => {
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
                    image: NetworkImage(photoUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: GymAudioWidget(
                  mediaURL: mediaUrl,
                  duration: duration,
                  title: title,
                ),
              ),
            );
          },
        ),
      };

  _showVideoDialog(context, photoUrl, mediaUrl) => {
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
                    image: NetworkImage(photoUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: VideoWidget(mediaUrl: mediaUrl),
              ),
            );
          },
        ),
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new RadialGradient(
              radius: MediaQuery.of(context).size.width / 50,
              colors: [
                Color.fromRGBO(89, 0, 224, 1),
                Color.fromRGBO(109, 42, 128, 1),
              ],
            ),
          ),
        ),
        leading: GestureDetector(
          child: Center(
            child: Icon(Icons.keyboard_arrow_left),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text("PQ"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/gym_back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          child: Text(
                            widget.time,
                            style: TextStyle(
                                color: Colors.blue[400],
                                fontWeight: FontWeight.w500),
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            border: Border.all(color: Colors.blue[300]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.description,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                child: ListView(
                    children: widget.files != null
                        ? widget.files
                            .map(
                              (item) => Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    padding: EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          margin: EdgeInsets.only(right: 15),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.orange[100],
                                          ),
                                          child: Icon(
                                            item.filetype == "mp4"
                                                ? Icons.movie
                                                : Icons.audiotrack,
                                            size: 20,
                                            color: Colors.orange[400],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.title,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${item.duration} min",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Icon(
                                                Icons.check,
                                                size: 25,
                                                color: Colors.green[700],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    item.filetype == "mp3"
                                        ? _showVideoDialog(
                                            context, item.photo, item.media)
                                        : _showAudioDialog(
                                            context,
                                            item.title,
                                            item.photo,
                                            item.media,
                                            item.duration,
                                          );
                                  },
                                ),
                              ),
                            )
                            .toList()
                        : [Container()]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
