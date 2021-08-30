

import 'dart:async';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:nlpower/model/common_day.dart';
import 'package:nlpower/model/day.dart';
import 'package:nlpower/model/group.dart';
import 'package:nlpower/model/item_detail.dart';
import 'package:nlpower/model/week.dart';
import 'package:nlpower/module/daily_module.dart';
import 'package:nlpower/module/user_module.dart';
import 'package:nlpower/widget/item_widget.dart';
import 'package:nlpower/widget/today_widget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DailyPage extends StatefulWidget{

  DailyPageState createState()=> DailyPageState();
}

class DailyPageState extends State<DailyPage> {

  Week current_week;
  List<Day> day_list = [];
  List<Group> group_list = [];
  bool daily_loading = false;
  List<CommonDay> commonday_list = [];
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  String get search => searchController.text;
  bool search_loading = false;
  Timer daily_timer;

  @override
  void initState() {
    super.initState();
    daily_timer = Timer.periodic(Duration(minutes: 1), (Timer t) => onUpdateDaily());
    getDailyInfo(int.parse(UserModule.user.level), int.parse(UserModule.user.week), 4);
  }

  onUpdateDaily() {
    DateTime now = DateTime.now();
    int level = int.parse(UserModule.user.level);
    int week = int.parse(UserModule.user.level);
    int day = int.parse(UserModule.user.day);
    if(now.hour < 1 && now.minute < 2){
      if(day >= 5){
        day = 1;
        week = week + 1;
      }
      else{
        day = day + 1;
      }
      UserModule.user.day = day.toString();
      UserModule.user.week = week.toString();
      getDailyInfo(level, week, day);
    }
    print("--------current_time:${now.hour}:${now.minute}");
  }

  Future<void> getDailyInfo(int level, int week, int day) async {
    daily_loading = true;
    current_week = null;
    await DailyModule.getDaily(level, week, day).then((week) async {
      if(week != null){
        current_week = week;
        if(current_week.days.length > 0){
          day_list = current_week.days;
          if(day_list[0].groups.length > 0){
            group_list = day_list[0].groups;
          }
        }
      }
      await DailyModule.getTracking();
      await DailyModule.getAllDay().then((list){
        commonday_list = [];
        if(list.length > 0){
          commonday_list = list;
        }
        setState(() {
          daily_loading = false;  
        });
      });
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Focus'),
        centerTitle: true,
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
      ),
      body: 
      Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    // color: Colors.black,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/counter_background.jpeg"),
                        fit: BoxFit.fill
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xffff6e08), Color(0xffb082b8)]
                            ),
                            shape: BoxShape.circle
                          ),
                          child: Stack(
                            children: [
                              
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 140, height: 140,
                                  decoration: DottedDecoration(
                                    shape: Shape.circle,
                                    color: Colors.black,
                                    strokeWidth: 10.0,
                                    dash: <int>[10, 15],
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Container(
                                        width: 70, height: 70,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [Color(0xffe48e97), Color(0xffce22c8), Color(0xff37a6f1), Color(0xff00bee4)]
                                          ),
                                          shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(2.5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset("assets/diagram.png", width: 30, height: 30,),
                                                Text(DailyModule.score == null ? "0" : DailyModule.score.toString(), style:TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                                Text('sdfsd', style:TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    )
                                  ),
                                )
                              ),
                              
                            ]
                          )
                        ),
                            
                      ],
                    )
                    
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width / 2 - 75 - 30,
                    top: 35,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 3.0, color: Colors.white)
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black
                              ),
                                child: Align(
                              alignment: Alignment.center,
                              child: Text(DailyModule.total == null ? '0/36' : DailyModule.total.toString() + '/36',
                                  style: TextStyle(color: Colors.white, fontSize: 11)),
                            )),
                          ),
                          Container(
                            height: 30,
                            child: Text('NL PQ \nReps', style: TextStyle(color: Colors.white, fontSize: 7,), textAlign: TextAlign.center,),
                          )
                        ]
                      )
                    )
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 + 75 - 20,
                    top: 75,
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  width: 40, height: 40,
                                  child: SfRadialGauge(
                                    axes: <RadialAxis>[
                                      RadialAxis(
                                          minimum: 0,
                                          maximum: 100,
                                          // startAngle: 270,
                                          // endAngle: 270,
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
                                              value: DailyModule.percent == null ? 0.0 : DailyModule.percent,
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
                                              DailyModule.percent == null ? "0%" : DailyModule.percent.toString()+ "\n%",
                                              style: TextStyle(fontSize: 11, color: Colors.white),
                                              )
                                            )
                                          ]
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('0%', style: TextStyle(color: Colors.white, fontSize: 9)),
                                      Text('100%', style: TextStyle(color: Colors.white, fontSize: 9))
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
                          Container(
                            width: 80,
                            child: Text('sdfsdf', style: TextStyle(color: Colors.white, fontSize: 9)),
                          )
                          
                        ],
                      ),
                    )
                  )
                ]
              ),
              Container(
                width: double.infinity,
                height: 70,               
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Image.asset("assets/left_bg.png", fit: BoxFit.fill),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            RaisedButton(
                              onPressed: () => {
                                displayBottomSheet(context)
                              },
                              color: Colors.white,
                              padding: EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.pinkAccent, width: 2)
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today_outlined, color: Colors.pinkAccent, size: 20),
                                  SizedBox(width: 10.0),
                                  Container(
                                    child: new Align(alignment:Alignment.center, child:Text("Today", style: TextStyle(color: Colors.pinkAccent, fontSize: 16),))
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 10.0),
                              GestureDetector(
                                onTap: () {
                                  displayBottomSheet(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.pinkAccent, width: 1.0)),
                                  ),
                                  child: Text('Focus Calendar',style: TextStyle(color: Colors.pinkAccent, fontSize: 14, fontWeight: FontWeight.bold)),
                                ),
                              ),
                          ]
                        )
                      ),
                      Image.asset("assets/right_bg.png"),
                  ],
                )
              ),
              daily_loading == false ?
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/edit_profile.jpg"),
                        fit: BoxFit.cover
                      )
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                        children:[
                          SizedBox(height: 10),
                          for(var group in group_list)
                            ItemWidget(group: group,),
                            
                        ]
                      )
                    )
                  )
                ): CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (ctx) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter mystate){
          return Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    
                    Text('Focus Calendar', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  // width: MediaQuery.of(context).size.width * 0.7,
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 8,
                    child: Container(
                      child: TextFormField(
                        controller: searchController,
                        focusNode: searchFocusNode,
                        cursorColor: Colors.orange[200],
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          prefixIcon:
                          Icon(Icons.search, color: Colors.orange[200], size: 30),
                          hintText: "search",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none),
                        ),
                        onChanged: (String name){
                          mystate((){
                            _updateState();
                          });
                          
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ),
                ),
                search_loading == false ?
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemCount: commonday_list.length,
                      itemBuilder: (BuildContext context, int index){
                        return Container(
                          child: Column(
                            children:[
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    getDailyInfo(int.parse(commonday_list[index].level), int.parse(commonday_list[index].week), int.parse(commonday_list[index].day));  
                                    Navigator.pop(context);                        
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(commonday_list[index].item_title, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                                            Text(commonday_list[index].date_created.split(' ')[0], style: TextStyle(color: Colors.black, fontSize: 14))
                                          ],
                                        ),
                                      )
                                    ),
                                    commonday_list[index].has_complete > 0 ?
                                    IconButton(
                                      onPressed: (){
                                      },
                                      icon: new Icon(Icons.check,  size: 30, color: Colors.green),
                                    ): Container(),
                                  ],
                                )
                              ),
                              Divider(height: 1.0, color: Colors.black)
                            ]
                          ),
                        );
                      }
                    ),
                  )
                ): CircularProgressIndicator()
                
              ],
            )
          );
        });
      }
    );
  }

  void _updateState() {
    search_loading = true;
    
    setState(() {
      if(search != null && search.isNotEmpty){
        if(DailyModule.commonday_list.length > 0){
          List<CommonDay> temp_list = [];
          for(int i = 0; i < DailyModule.commonday_list.length; i++) {
            if(DailyModule.commonday_list[i].item_title.contains(search.toUpperCase()) || DailyModule.commonday_list[i].item_title.contains(search.toLowerCase())){
              temp_list.add(DailyModule.commonday_list[i]);
              print('search: $search');
            }
          }
          commonday_list = temp_list;
        }
      }
      else{
        commonday_list = [];
        commonday_list = DailyModule.commonday_list;
      }
      print('search: $search');
      search_loading = false;
    });
  }

  // void showFoucsCalendarDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context){
  //       return StatefulBuilder(builder: (context, setState){
  //         return AlertDialog(
  //           title: Container(
  //             child: Column(
  //               children:[
  //                 Container(
  //                   child: Align(
  //                     alignment: Alignment.topRight,
  //                     child: IconButton(
  //                       onPressed: (){
  //                       },
  //                       icon: new Icon(Icons.cancel,  size: 30, color: Colors.black),
  //                     ),
  //                   )
  //                 ),
  //                 select_button == false ?
  //                   Column(
  //                     children: [
  //                       Text('Warning', style:TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
  //                       Text("You haven't completed your \nPreviouse Focus of the Day", style:TextStyle(color: Colors.black, fontSize: 16,)),
  //                       Text('Aim to Serve', style:TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
  //                       Text("Do you want to complete it today?", style:TextStyle(color: Colors.black, fontSize: 16,)),
  //                       Container(
  //                         width: double.infinity,
  //                         padding: EdgeInsets.only(left: 10, right: 10),
  //                         child: RaisedButton(
  //                           onPressed: () => {
  //                           },
  //                           textColor: Colors.white,
  //                           color: Color(0xFF00b2c4),
  //                           padding: EdgeInsets.all(10.0),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(20.0),
  //                           ),
  //                           child: Text("Yes", style: TextStyle(fontSize: 16),)
  //                         ),
  //                       ),
  //                       Container(
  //                         width: double.infinity,
  //                         padding: EdgeInsets.only(left: 10, right: 10),
  //                         child: RaisedButton(
  //                           onPressed: (){
  //                             setState((){
  //                               select_button = true;
  //                             });
  //                           },
  //                           textColor: Colors.black,
  //                           color: Colors.white.withOpacity(0.6),
  //                           padding: EdgeInsets.all(10.0),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(20.0),
  //                           ),
  //                           child: Text("No, I want another Focus", style: TextStyle(fontSize: 16),)
  //                         ),
  //                       )
  //                     ],
  //                   ):
  //                   Column(
  //                     children: [
  //                       Text('Change of focus', style:TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
  //                       Text("Would you like to try a different \n Focus for the day?", style:TextStyle(color: Colors.black, fontSize: 16,)),
  //                       Container(
  //                         width: double.infinity,
  //                         padding: EdgeInsets.only(left: 10, right: 10),
  //                         child: RaisedButton(
  //                           onPressed: () => {
  //                           },
  //                           textColor: Colors.white,
  //                           color: Color(0xFF00b2c4),
  //                           padding: EdgeInsets.all(10.0),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(20.0),
  //                           ),
  //                           child: Text("Select", style: TextStyle(fontSize: 16),)
  //                         ),
  //                       ),
                        
  //                     ],
  //                   )
                  
  //               ]
  //             ),
  //           ),
  //         );
  //       });
  //     });
  //   }
  
}