

import 'package:flutter/material.dart';
import 'package:nlpower/widget/battery_widget.dart';
import 'package:nlpower/widget/muscle_widget.dart';
import 'package:nlpower/widget/pqreps_widget.dart';

class TodayWidget extends StatefulWidget {
  
  TodayWidgetState createState()=> TodayWidgetState();
}

class TodayWidgetState extends State<TodayWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.withOpacity(0.1),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 110,
            color: Colors.white,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PQRepsBar(m_color: Colors.black),
                ),
                BatteryWidget(m_color: Colors.black),
                Expanded(
                  child: MuscleWidget(m_color: Colors.black,)
                )
                
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RaisedButton(
                  onPressed: () => {

                  },
                  color: Color(0xFFeaeaea),
                  padding: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    // side: BorderSide(color: Colors.pinkAccent, width: 2)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, color: Colors.black, size: 15),
                      SizedBox(width: 10.0),
                      Container(
                        child: new Align(alignment:Alignment.center, child:Text("June 11", style: TextStyle(color: Colors.black, fontSize: 14),))
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10),
                RaisedButton(
                  onPressed: () => {

                  },
                  color: Color(0xFFeaeaea),
                  padding: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    // side: BorderSide(color: Colors.pinkAccent, width: 2)
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: new Align(alignment:Alignment.center, child:Text("Back To Today", style: TextStyle(color: Colors.black, fontSize: 14),))
                      )
                    ],
                  ),
                ),
                
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Card(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset("assets/activate.png", width: 40, height: 40),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Label with an Anchor', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                              Text('Completed', style: TextStyle(color: Colors.black, fontSize: 14))
                            ],
                          ),
                        )
                      ),
                      IconButton(
                        onPressed: (){
                        },
                        icon: new Icon(Icons.check,  size: 30, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
  
}