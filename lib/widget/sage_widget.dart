
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class SageWidget extends StatefulWidget {

  SageWidgetState createState()=> SageWidgetState();
}

class SageWidgetState extends State<SageWidget> with TickerProviderStateMixin{

  AnimationController explore_animationController;
  Animation<double> animation;
  String explore_progress_value = "";

  AnimationController empathize_animationController;
  Animation<double> empathize_animation;
  String empathize_progress_value = "";

  AnimationController activate_animationController;
  Animation<double> activate_animation;
  String activate_progress_value = "";

  AnimationController navigate_animationController;
  Animation<double> navigate_animation;
  String navigate_progress_value = "";

  AnimationController innovate_animationController;
  Animation<double> innovate_animation;
  String innovate_progress_value = "";

  @override
  void initState() {
    super.initState();
    explore_animationController = AnimationController(vsync: this, duration: Duration(seconds: 5,));
      animation = Tween(begin: 0.0, end: 1.0).animate(explore_animationController)
      ..addListener(() {
        setState(() {
          explore_progress_value = (explore_animationController.value * 80).toStringAsFixed(0) + "%";
        });
      });
    explore_animationController.forward();

    empathize_animationController = AnimationController(vsync: this, duration: Duration(seconds: 5,));
      empathize_animation = Tween(begin: 0.0, end: 1.0).animate(empathize_animationController)
      ..addListener(() {
        setState(() {
          empathize_progress_value = (empathize_animationController.value * 70).toStringAsFixed(0) + "%";
        });
      });
    empathize_animationController.forward();

    navigate_animationController = AnimationController(vsync: this, duration: Duration(seconds: 5,));
      navigate_animation = Tween(begin: 0.0, end: 1.0).animate(navigate_animationController)
      ..addListener(() {
        setState(() {
          navigate_progress_value = (navigate_animationController.value * 70).toStringAsFixed(0) + "%";
        });
      });
    navigate_animationController.forward();

    activate_animationController = AnimationController(vsync: this, duration: Duration(seconds: 5,));
      activate_animation = Tween(begin: 0.0, end: 1.0).animate(activate_animationController)
      ..addListener(() {
        setState(() {
          activate_progress_value = (activate_animationController.value * 70).toStringAsFixed(0) + "%";
        });
      });
    activate_animationController.forward();

    innovate_animationController = AnimationController(vsync: this, duration: Duration(seconds: 5,));
      innovate_animation = Tween(begin: 0.0, end: 1.0).animate(innovate_animationController)
      ..addListener(() {
        setState(() {
          innovate_progress_value = (innovate_animationController.value * 70).toStringAsFixed(0) + "%";
        });
      });
    innovate_animationController.forward();
  }

  @override
  void dispose(){
    explore_animationController.stop();
    empathize_animationController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              width: double.infinity,
              child: Text('Your Sage has five super powers that grow with practice.', style: TextStyle(color: Colors.black, fontSize: 20),)
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Sage_BG.png'),
                  fit: BoxFit.cover
                )
                
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: double.infinity,
                    child: Row(
                      children:[
                        Container(
                          width: 50,
                          height: 50,
                          child: CircleAvatar(
                            child: Image.asset('assets/explore.png', fit: BoxFit.fill,),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Explore', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                    SizedBox(width: 10),
                                    Text('Level2', style: TextStyle(color: Colors.red)),
                                    Expanded(
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(explore_progress_value, style: TextStyle(color: Colors.black)),
                                        ),
                                      )
                                      
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                FAProgressBar(
                                  currentValue: 80,
                                  maxValue: 100,
                                  size: 20,
                                  backgroundColor: Colors.transparent,
                                  progressColor: Colors.lightBlue,
                                  animatedDuration: Duration(seconds: 3),
                                  direction: Axis.horizontal,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.lightBlue),
                                  displayText: null,
                                )
                              ]
                            )
                          )
                        )
                      ]
                    )
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: double.infinity,
                    child: Row(
                      children:[
                        Container(
                          width: 50, height: 50,
                          child: CircleAvatar(
                            child: Image.asset('assets/empathize.png',fit: BoxFit.fill,),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Empathize', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                    SizedBox(width: 10),
                                    Text('Level2', style: TextStyle(color: Colors.red)),
                                    Expanded(
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(empathize_progress_value, style: TextStyle(color: Colors.black)),
                                        ),
                                      )
                                      
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                FAProgressBar(
                                  currentValue: 70,
                                  maxValue: 100,
                                  size: 20,
                                  backgroundColor: Colors.transparent,
                                  progressColor: Colors.lightBlue,
                                  animatedDuration: Duration(seconds: 3),
                                  direction: Axis.horizontal,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.lightBlue),
                                  displayText: null,
                                )
                              ]
                            )
                          )
                        )
                      ]
                    )
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: double.infinity,
                    child: Row(
                      children:[
                        Container(
                          width: 50,
                          height: 50,
                          child: CircleAvatar(
                            child: Image.asset('assets/navigate.png',fit: BoxFit.fill,),
                          ),
                        ),
                        
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Navigate', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                    SizedBox(width: 10),
                                    Text('Level2', style: TextStyle(color: Colors.red)),
                                    Expanded(
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(navigate_progress_value, style: TextStyle(color: Colors.black)),
                                        ),
                                      )
                                      
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                FAProgressBar(
                                  currentValue: 70,
                                  maxValue: 100,
                                  size: 20,
                                  backgroundColor: Colors.transparent,
                                  progressColor: Colors.lightBlue,
                                  animatedDuration: Duration(seconds: 3),
                                  direction: Axis.horizontal,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.lightBlue),
                                  displayText: null,
                                )
                              ]
                            )
                          )
                        )
                      ]
                    )
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: double.infinity,
                    child: Row(
                      children:[
                        Container(
                          width: 50,height: 50,
                          child: CircleAvatar(
                            child: Image.asset('assets/activate.png',fit: BoxFit.fill,),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Activate', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                    SizedBox(width: 10),
                                    Text('Level2', style: TextStyle(color: Colors.red)),
                                    Expanded(
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(activate_progress_value, style: TextStyle(color: Colors.black)),
                                        ),
                                      )
                                      
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                FAProgressBar(
                                  currentValue: 80,
                                  maxValue: 100,
                                  size: 20,
                                  backgroundColor: Colors.transparent,
                                  progressColor: Colors.lightBlue,
                                  animatedDuration: Duration(seconds: 3),
                                  direction: Axis.horizontal,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.lightBlue),
                                  displayText: null,
                                )
                              ]
                            )
                          )
                        )
                      ]
                    )
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: double.infinity,
                    child: Row(
                      children:[
                        Container(
                          width: 50, height: 50,
                          child: CircleAvatar(
                            child: Image.asset('assets/innovate.png',fit: BoxFit.fill,),
                          ),
                        ),
                        
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Innovate', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                    SizedBox(width: 10),
                                    Text('Level2', style: TextStyle(color: Colors.red)),
                                    Expanded(
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(innovate_progress_value, style: TextStyle(color: Colors.black)),
                                        ),
                                      )
                                      
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                FAProgressBar(
                                  currentValue: 80,
                                  maxValue: 100,
                                  size: 20,
                                  backgroundColor: Colors.transparent,
                                  progressColor: Colors.lightBlue,
                                  animatedDuration: Duration(seconds: 3),
                                  direction: Axis.horizontal,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.lightBlue),
                                  displayText: null,
                                )
                              ]
                            )
                          )
                        )
                      ]
                    )
                  )
                ]
              )
            )
            )
          ],
        )
    );
  }
  
}