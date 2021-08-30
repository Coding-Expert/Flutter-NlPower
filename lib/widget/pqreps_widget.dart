

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PQRepsBar extends StatefulWidget{

  final Color m_color;
  PQRepsBar({
    Key key,
    this.m_color
  }): super(key: key);
  
  PQRepsBarState createState()=> PQRepsBarState();
}

class PQRepsBarState extends State<PQRepsBar> {

  double pqreps_value = 0;
  Timer pqreps_timer;


  @override
  void initState() {
    super.initState();
    pqreps_timer = Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
      setState(() {
        pqreps_value++;
        if(pqreps_value == 80) {
          pqreps_timer.cancel();
        }        
      });
    });
    
  }

  @override
  void dispose(){
    pqreps_timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  startAngle: 270,
                  endAngle: 270,
                  showLabels: false,
                  showTicks: false,
                  axisLineStyle: AxisLineStyle(
                    thickness: 0.2,
                    cornerStyle: CornerStyle.bothCurve,
                    color: Color.fromARGB(30, 0, 169, 181),
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: pqreps_value,
                      cornerStyle: CornerStyle.bothCurve,
                      width: 0.2,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 100,
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                    positionFactor: 0.1,
                    angle: 90,
                    widget: Text(
                      pqreps_value.toStringAsFixed(0) + ' / 100',
                      style: TextStyle(fontSize: 11, color: widget.m_color),
                      )
                    )
                  ]
              )
            ],
          )
        ),
        Text('PQReps', style:TextStyle(color: widget.m_color,))
      ]
    );
  }
  
}