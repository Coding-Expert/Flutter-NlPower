

import 'dart:async';

import 'package:battery_indicator/battery_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:nlpower/pages/dashboard_widget.dart';
import 'package:nlpower/pages/profile.dart';
import 'package:nlpower/widget/linechart.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DashboardPage extends StatefulWidget{

  DashboardPageState createState()=> DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin{

  
  bool profile_page = false;

  @override
  Widget build(BuildContext context) {
    // percentage = _animationController.value * 80;
    return Scaffold(
      appBar: AppBar(
        title:  Text(profile_page == false ? 'Dashboard' : 'Edit your profile'),
        centerTitle: true,
        leading: profile_page == true ?
          IconButton(
            icon: Icon(Icons.keyboard_arrow_left_sharp),
            onPressed: (){
              setState(() {
                profile_page = false;       
              });
            },
          ): Container(),
        actions: [
          profile_page == false ?
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){
                setState(() {
                  profile_page = true;       
                });
              },
            ): Container(),
          profile_page == true ?
            IconButton(
              icon: Icon(Icons.save),
              onPressed: (){
                // setState(() {
                //   profile_page = true;       
                // });
              },
            ): Container(),
        ],
      ),
      body: profile_page == false ?
          DashboardWidget()
          : ProfilePage()
    );
  }
  
}