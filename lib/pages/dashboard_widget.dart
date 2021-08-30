
import 'dart:async';

import 'package:battery_indicator/battery_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:nlpower/module/user_module.dart';
import 'package:nlpower/pages/profile.dart';
import 'package:nlpower/widget/battery_widget.dart';
import 'package:nlpower/widget/linechart.dart';
import 'package:nlpower/widget/muscle_widget.dart';
import 'package:nlpower/widget/pqreps_widget.dart';
import 'package:nlpower/widget/sage_widget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DashboardWidget extends StatefulWidget {

  DashboardWidgetState createState()=> DashboardWidgetState();
}

class DashboardWidgetState extends State<DashboardWidget> with SingleTickerProviderStateMixin {

  PageController _pageController;
  
 
  
  double percentage;
  bool pqresps_flag = true;
  AnimationController controller;
  bool profile_page = false;
  
  

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    
  }

  @override
  void dispose(){
    // controller.stop();
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(profile_page == false ? 'Dashboard' : 'Edit your profile'),
        // centerTitle: true,
        // leading: profile_page == true ?
        //   IconButton(
        //     icon: Icon(Icons.keyboard_arrow_left_sharp),
        //     onPressed: (){
        //       setState(() {
        //         profile_page = false;       
        //       });
        //     },
        //   ): Container(),
        actions: [
          // profile_page == false ?
          //   IconButton(
          //     icon: Icon(Icons.edit),
          //     onPressed: (){
          //       setState(() {
          //         profile_page = true;       
          //       });
          //     },
          //   ): Container(),
          profile_page == true ?
            GestureDetector(
              onTap: (){
                setState(() {
                  profile_page = false;       
                });
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 70,
                  child: Text('CLOSE', style: TextStyle(fontSize: 18)),
                ),
              )
              
            ) :
            Container()

            // IconButton(
            //   icon: Icon(Icons.save),
            //   onPressed: (){
            //     setState(() {
            //       profile_page = true;       
            //     });
            //   },
            // ): Container(),
        ],
      ),
      body: profile_page == false ?
      Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset("assets/name.png", width:MediaQuery.of(context).size.width * 0.3  , height: MediaQuery.of(context).size.height * 0.1, fit: BoxFit.cover,),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          child: UserModule.user.image == null ?
                          CircleAvatar(
                            child: Image.asset('assets/login.png', fit: BoxFit.fill,),
                          ):
                          ClipOval(
                            child: Image.network(UserModule.user.image, fit: BoxFit.fill, width: 60, height: 60)
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black,),
                              top: BorderSide(color: Colors.black,),
                            ),
                          ),
                          child: new Align(alignment: Alignment.center , child: Text('${UserModule.user.firstname} ${UserModule.user.lastname}', style:TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28))),
                        ),
                        Expanded(
                          child: Container(
                            child: Align(
                              alignment: Alignment.centerRight, 
                              child: IconButton(
                                icon: Icon(Icons.arrow_forward_ios_sharp),
                                onPressed: (){
                                  setState(() {
                                    profile_page = true;       
                                  });
                                },
                              ),
                            ),
                          )
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                          setState(() {
                            _pageController.animateToPage(0,duration: const Duration(milliseconds: 400),curve: Curves.easeInOut,); 
                            pqresps_flag = true;    
                            // _animationController.reset(); 
                          });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color:pqresps_flag == true ? Colors.blue : Colors.white,),
                          ),
                        ),
                        child: new Align(alignment: Alignment.center , child: Text('PQReps', style:TextStyle(color:pqresps_flag == true ? Colors.blue : Colors.grey, fontWeight: FontWeight.bold, fontSize: 24))),
                      )
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  Container(
                    height: 40,
                    child: VerticalDivider(color: Colors.black),
                  ),
                  SizedBox(width: 5.0,),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                          setState(() {
                            _pageController.animateToPage(1,duration: const Duration(milliseconds: 400),curve: Curves.easeInOut,);
                            pqresps_flag = false;
                            // _animationController.forward();
                                                
                          });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: pqresps_flag == false ? Colors.blue : Colors.white,),
                          ),
                        ),
                        child: new Align(alignment: Alignment.center , child: Text('Sage', style:TextStyle(color:pqresps_flag == false ? Colors.blue : Colors.grey, fontWeight: FontWeight.bold, fontSize: 24))),
                      )
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: PageView(
                  controller: _pageController,
                  physics: new NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    PQRepsWidget(),
                    SageWidget()
                    // Sage(),
                  ],
                )
              )
            )
          ],
        ),
      ): ProfilePage(
        onRefreshPage: (String result){
          if(result == "success"){
            setState(() {
              profile_page = false;                  
            });
          }
        },
      )
    );
  }

  Widget PQRepsWidget() {
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            child: Text(
              'PQ Reps boost your Self-Command muscle the same way that dumbbell reps would boost your physical body.',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/pq reps counters BG.jpg'),
                fit: BoxFit.cover
              )
              
            ),
            width: MediaQuery.of(context).size.width,
            height: 120,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PQRepsBar(m_color: Colors.white,),
                ),
                // ChargingBar(percentage),
                // batteryBar(),
                BatteryWidget(m_color: Colors.white,),
                Expanded(
                  child: MuscleWidget(m_color: Colors.white,)
                )
                
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('PQMuscle', style: TextStyle(color: Colors.black, fontSize: 18)),
                // SizedBox(width: 5),
                Container(
                  height: 10.0,
                  width: 10.0,
                  decoration: BoxDecoration(
                      color: Color(0xfffa913a),
                      shape: BoxShape.circle
                  ),
                ),
                // SizedBox(width: 5),
                Text('Min', style: TextStyle(color: Colors.black, fontSize: 18)),
                // SizedBox(width: 5),
                Container(
                  height: 10.0,
                  width: 10.0,
                  decoration: BoxDecoration(
                      color: Color(0xff00aee8),
                      shape: BoxShape.circle
                  ),
                ),
                // SizedBox(width: 5),
                Text('Recommended', style: TextStyle(color: Colors.black, fontSize: 18)),
                // SizedBox(width: 5),
                Container(
                  height: 10.0,
                  width: 10.0,
                  decoration: BoxDecoration(
                      color: Color(0xff00ff21),
                      shape: BoxShape.circle
                  ),
                ),
                // SizedBox(width: 5),
                Text('You', style: TextStyle(color: Colors.black, fontSize: 18)),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          Expanded(
            child: Container(
              child: LineChart(
                // m_height: 340,
              ),
            )
          )
          
        ],
      ),
    );
  }

  // Widget Sage() {
  //   return Container(
  //     padding: EdgeInsets.only(left: 10, right: 10),
  //     width: MediaQuery.of(context).size.width,
  //       child: Column(
  //         children: [
  //           Padding(padding: EdgeInsets.only(top: 10)),
  //           Container(
  //             width: double.infinity,
  //             child: Text('Your Sage has five super powers that grow with practice.', style: TextStyle(color: Colors.black, fontSize: 20),)
  //           ),
  //           Padding(padding: EdgeInsets.only(top: 10)),
  //           Expanded(
  //           child: Container(
  //             width: double.infinity,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 Container(
  //                   width: double.infinity,
  //                   child: Row(
  //                     children:[
  //                       CircleAvatar(
  //                         child: Image.asset('images/login_logo.png',fit: BoxFit.fill,),
  //                       ),
  //                       SizedBox(width: 10),
  //                       Expanded(
  //                         child: Container(
  //                           child: Column(
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   Text('Explore', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
  //                                   SizedBox(width: 10),
  //                                   Text('Level2', style: TextStyle(color: Colors.red)),
  //                                 ],
  //                               ),
  //                               SizedBox(height: 5),
  //                               FAProgressBar(
  //                                 currentValue: 80,
  //                                 maxValue: 100,
  //                                 size: 25,
  //                                 backgroundColor: Colors.transparent,
  //                                 progressColor: Colors.lightBlue,
  //                                 animatedDuration: Duration(seconds: 3),
  //                                 direction: Axis.horizontal,
  //                                 borderRadius: BorderRadius.circular(15),
  //                                 border: Border.all(color: Colors.lightBlue),
  //                                 displayText: null,
  //                               )
  //                             ]
  //                           )
  //                         )
  //                       )
  //                     ]
  //                   )
  //                 ),
  //                 Container(
  //                   width: double.infinity,
  //                   child: Row(
  //                     children:[
  //                       CircleAvatar(
  //                         child: Image.asset('images/login_logo.png',fit: BoxFit.fill,),
  //                       ),
  //                       SizedBox(width: 10),
  //                       Expanded(
  //                         child: Container(
  //                           child: Column(
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   Text('Empathize', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
  //                                   SizedBox(width: 10),
  //                                   Text('Level2', style: TextStyle(color: Colors.red)),
  //                                   Expanded(
  //                                     child: Container(
  //                                       child: Align(
  //                                         alignment: Alignment.centerRight,
  //                                         child: Text(progress_value, style: TextStyle(color: Colors.black)),
  //                                       ),
  //                                     )
                                      
  //                                   )
  //                                 ],
  //                               ),
  //                               SizedBox(height: 5),
  //                               FAProgressBar(
  //                                 currentValue: 80,
  //                                 maxValue: 100,
  //                                 size: 25,
  //                                 backgroundColor: Colors.transparent,
  //                                 progressColor: Colors.lightBlue,
  //                                 animatedDuration: Duration(seconds: 3),
  //                                 direction: Axis.horizontal,
  //                                 borderRadius: BorderRadius.circular(15),
  //                                 border: Border.all(color: Colors.lightBlue),
  //                                 displayText: null,
  //                               )
  //                             ]
  //                           )
  //                         )
  //                       )
  //                     ]
  //                   )
  //                 ),
  //                 Container(
  //                   width: double.infinity,
  //                   child: Row(
  //                     children:[
  //                       CircleAvatar(
  //                         child: Image.asset('images/login_logo.png',fit: BoxFit.fill,),
  //                       ),
  //                       SizedBox(width: 10),
  //                       Expanded(
  //                         child: Container(
  //                           child: Column(
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   Text('Navigate', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
  //                                   SizedBox(width: 10),
  //                                   Text('Level2', style: TextStyle(color: Colors.red))
  //                                 ],
  //                               ),
  //                               SizedBox(height: 5),
  //                               FAProgressBar(
  //                                 currentValue: 80,
  //                                 maxValue: 100,
  //                                 size: 25,
  //                                 backgroundColor: Colors.transparent,
  //                                 progressColor: Colors.lightBlue,
  //                                 animatedDuration: Duration(seconds: 3),
  //                                 direction: Axis.horizontal,
  //                                 borderRadius: BorderRadius.circular(15),
  //                                 border: Border.all(color: Colors.lightBlue),
  //                                 displayText: null,
  //                               )
  //                             ]
  //                           )
  //                         )
  //                       )
  //                     ]
  //                   )
  //                 ),
  //                 Container(
  //                   width: double.infinity,
  //                   child: Row(
  //                     children:[
  //                       CircleAvatar(
  //                         child: Image.asset('images/login_logo.png',fit: BoxFit.fill,),
  //                       ),
  //                       SizedBox(width: 10),
  //                       Expanded(
  //                         child: Container(
  //                           child: Column(
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   Text('Activate', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
  //                                   SizedBox(width: 10),
  //                                   Text('Level2', style: TextStyle(color: Colors.red))
  //                                 ],
  //                               ),
  //                               SizedBox(height: 5),
  //                               FAProgressBar(
  //                                 currentValue: 80,
  //                                 maxValue: 100,
  //                                 size: 25,
  //                                 backgroundColor: Colors.transparent,
  //                                 progressColor: Colors.lightBlue,
  //                                 animatedDuration: Duration(seconds: 3),
  //                                 direction: Axis.horizontal,
  //                                 borderRadius: BorderRadius.circular(15),
  //                                 border: Border.all(color: Colors.lightBlue),
  //                                 displayText: null,
  //                               )
  //                             ]
  //                           )
  //                         )
  //                       )
  //                     ]
  //                   )
  //                 ),
  //                 Container(
  //                   width: double.infinity,
  //                   child: Row(
  //                     children:[
  //                       CircleAvatar(
  //                         child: Image.asset('images/login_logo.png',fit: BoxFit.fill,),
  //                       ),
  //                       SizedBox(width: 10),
  //                       Expanded(
  //                         child: Container(
  //                           child: Column(
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   Text('Innovate', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
  //                                   SizedBox(width: 10),
  //                                   Text('Level2', style: TextStyle(color: Colors.red))
  //                                 ],
  //                               ),
  //                               SizedBox(height: 5),
  //                               FAProgressBar(
  //                                 currentValue: 80,
  //                                 maxValue: 100,
  //                                 size: 25,
  //                                 backgroundColor: Colors.transparent,
  //                                 progressColor: Colors.lightBlue,
  //                                 animatedDuration: Duration(seconds: 3),
  //                                 direction: Axis.horizontal,
  //                                 borderRadius: BorderRadius.circular(15),
  //                                 border: Border.all(color: Colors.lightBlue),
  //                                 displayText: null,
  //                               )
  //                             ]
  //                           )
  //                         )
  //                       )
  //                     ]
  //                   )
  //                 )
  //               ]
  //             )
  //           )
  //           )
  //         ],
  //       )
  //   );
  // }

  Widget ChargingBar(double percent){
    return Column(
      children: [
        Container(
          child: SizedBox(
            width: 70.0,
            height: 70.0,
            child: LiquidCircularProgressIndicator(
              value: percentage / 100,//_animationController.value,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              center: Text(
                "${percent.toStringAsFixed(0)}%",
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Text('Daily charging', style: TextStyle(color: Colors.white))
      ]
    );
  }
  
}