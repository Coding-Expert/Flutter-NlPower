

import 'package:battery_indicator/battery_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class BatteryWidget extends StatefulWidget{

  final Color m_color;
  BatteryWidget({
    Key key,
    this.m_color
  }): super(key: key);
  
  BatteryWidgetState createState()=> BatteryWidgetState();
}

class BatteryWidgetState extends State<BatteryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: SizedBox(
            width: 90.0,
            height: 70.0,
            child: Stack(
              children: [
                Center(
                  child: BatteryIndicator(
                    style: BatteryIndicatorStyle.values[1],
                    colorful: true,
                    showPercentNum: false,
                    mainColor: Color(0xff00c0ee),
                    size: 50.0,
                    ratio: 2.5,
                    showPercentSlide: false,
                    
                  ),
                ),
                Container(
                  // width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.only(left: 4, right: 12, top: 15, bottom: 15),
                  child: FAProgressBar(
                    currentValue: 80,
                    maxValue: 100,
                    size: 30,
                    backgroundColor: Colors.transparent,
                    progressColor: Color(0xff00c0ee),
                    animatedDuration: Duration(seconds: 3),
                    direction: Axis.horizontal,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.lightBlue),
                    displayText: '%',
                    displayTextStyle: TextStyle(color: widget.m_color, fontSize: 18),
                  )
                )
              ],
            )
            
          ),
        ),
        Text('Daily charging', style: TextStyle(color: widget.m_color))
      ]
    );
  }
  
}