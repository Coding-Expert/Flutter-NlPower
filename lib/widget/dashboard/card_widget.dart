import 'package:flutter/material.dart';
import 'package:nlpower/model/media.dart';
import 'package:nlpower/widget/dashboard/weekly.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DashboardCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final int completePercent;
  final String time;
  final Media media;
  const DashboardCardWidget(
      {this.title,
      this.description,
      this.completePercent,
      this.time,
      this.media,
      Key key})
      : super(key: key);

  @override
  _DashboardCardWidgetState createState() => _DashboardCardWidgetState();
}

class _DashboardCardWidgetState extends State<DashboardCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.description,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: EdgeInsets.only(right: 15),
                      child: SleekCircularSlider(
                        initialValue: widget.completePercent.toDouble(),
                        appearance: CircularSliderAppearance(
                          size: 120,
                          startAngle: 90,
                          angleRange: 360,
                          customWidths: CustomSliderWidths(
                            handlerSize: 0,
                            progressBarWidth: 8.0,
                          ),
                          customColors: CustomSliderColors(
                            shadowColor: Colors.white,
                            trackColor: Colors.white,
                          ),
                          infoProperties: InfoProperties(
                            mainLabelStyle: TextStyle(
                              color: Colors.purple[400],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Text(
                    "${widget.time} min",
                    style: TextStyle(
                        color: Colors.blue[400], fontWeight: FontWeight.w500),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    border: Border.all(color: Colors.blue[300]),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) => new WeeklyWidget(
                title: widget.title,
                description: widget.description,
                totalTime: widget.time,
                media: widget.media,
              ),
            ),
          );
        },
      ),
    );
  }
}
