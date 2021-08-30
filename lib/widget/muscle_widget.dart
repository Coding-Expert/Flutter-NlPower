

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MuscleWidget extends StatefulWidget {

  final Color m_color;
  MuscleWidget({
    Key key,
    this.m_color
  }) : super(key: key);

  MuscleWidgetState createState()=> MuscleWidgetState();
}

class MuscleWidgetState extends State<MuscleWidget> {

  double muscle_value = 0;
  Timer muscule_timer;

   @override
  void initState() {
    super.initState();
    muscule_timer = Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
      setState(() {
        muscle_value++;
        if(muscle_value == 80) {
          muscule_timer.cancel();
        }        
      });
    });
  }

  @override
  void dispose(){
    muscule_timer.cancel();
    // controller.stop();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          child:SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                startAngle: 270,
                endAngle: 270,
                showLabels: false,
                showTicks: false,
                // radiusFactor: 0.8,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.3,
                  color: const Color.fromARGB(40, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                      value: muscle_value,
                      width: 0.3,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 100,
                      animationType: AnimationType.linear
                  )
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      positionFactor: 0.2,
                      horizontalAlignment: GaugeAlignment.center,
                      widget: Text(muscle_value.toStringAsFixed(0), style:TextStyle(color: widget.m_color)))
                ]
              ),
              RadialAxis(
                minimum: 0,
                maximum: 100,
                startAngle: 270,
                endAngle: 270,
                showLabels: false,
                showTicks: false,
                showAxisLine: true,
                tickOffset: -0.05,
                offsetUnit: GaugeSizeUnit.factor,
                minorTicksPerInterval: 0,
                // radiusFactor: 0.8,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.3,
                  color: Colors.white,
                  dashArray: <double>[4, 3],
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
              )
            ]
          )
        ),
        Text('Muscle', style: TextStyle(color: widget.m_color))
      ]
    );
  }
  
}