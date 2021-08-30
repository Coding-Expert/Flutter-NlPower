import 'dart:convert';

import 'package:flutter/material.dart';

import 'audio_card.dart';

class CardGroupWidget extends StatefulWidget {
  final String groupTitle;
  final List<dynamic> medias;
  const CardGroupWidget({this.groupTitle, this.medias, Key key})
      : super(key: key);

  @override
  _CardGroupWidgetState createState() => _CardGroupWidgetState();
}

class _CardGroupWidgetState extends State<CardGroupWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.groupTitle,
            style: TextStyle(
              color: Color.fromRGBO(214, 88, 92, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 180,
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: widget.medias.length > 0
                  ? widget.medias.map((media) {
                      return AudioCard(
                        photoURL: media['photo'],
                        duration: media['duration'],
                        mediaURL: media['media'],
                        title: media['title'],
                      );
                    }).toList()
                  : [Text("")],
            ),
          ),
        ],
      ),
    );
  }
}
