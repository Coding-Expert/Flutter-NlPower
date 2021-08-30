import 'package:flutter/material.dart';
import 'package:nlpower/model/media.dart';
import 'package:nlpower/widget/dashboard/weekly_detail.dart';
import 'package:timelines/timelines.dart';

class WeeklyWidget extends StatefulWidget {
  final String title;
  final String description;
  final Media media;
  final String totalTime;
  const WeeklyWidget(
      {this.title, this.description, this.totalTime, this.media, Key key})
      : super(key: key);

  @override
  _WeeklyWidgetState createState() => _WeeklyWidgetState();
}

class _WeeklyWidgetState extends State<WeeklyWidget> {
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
                            "${widget.totalTime} min",
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
                child: Timeline.tileBuilder(
                  theme: TimelineThemeData(
                    nodePosition: 0,
                    connectorTheme: ConnectorThemeData(
                      thickness: 3.0,
                    ),
                  ),
                  builder: TimelineTileBuilder.connected(
                    indicatorBuilder: (context, index) {
                      return DotIndicator(
                        color: Colors.green[100],
                        size: 60,
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      );
                    },
                    connectorBuilder: (_, index, connectorType) {
                      return SolidLineConnector(
                        indent: connectorType == ConnectorType.start ? 0 : 2.0,
                        endIndent: connectorType == ConnectorType.end ? 0 : 2.0,
                        color: Colors.grey[700],
                      );
                    },
                    // contentsAlign: ContentsAlign.basic,
                    contentsBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 30, bottom: 30),
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.media.title,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.media.total_time,
                                ),
                              ],
                            ),
                            Icon(
                              Icons.check,
                              size: 30,
                              color: Colors.green[700],
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new WeeklyDetailWidget(
                                title: widget.media.title,
                                description: widget.media.description,
                                files: widget.media.files,
                                time: widget.media.total_time,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    itemCount: 1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
