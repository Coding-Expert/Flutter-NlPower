

import 'package:flutter/material.dart';
import 'package:nlpower/model/group.dart';
import 'package:nlpower/widget/audio_widget.dart';
import 'package:nlpower/widget/question_widget.dart';

class ItemWidget extends StatefulWidget {

  final Group group;

  ItemWidget({
    Key key,
    this.group
  }) : super(key: key);

  ItemWidgetState createState()=> ItemWidgetState();
}

class ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              if(widget.group.item_type == "sound"){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AudioWidget(
                  group: widget.group,
                )));
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionWidget(
                  group: widget.group,
                )));
              }
            },
            child:Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              color: Colors.black.withOpacity(0.7),
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50, height: 50,
                    child: Image.asset('assets/complete_key.png',fit: BoxFit.fill,),
                  ),
                  SizedBox(width: 10.0,),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.group.item_title, style:TextStyle(color: Colors.white)),
                          Text('completed', style:TextStyle(color: Colors.white)),
                        ],
                      ),
                    )
                  ),
                  Container(
                    width: 30, height: 40,
                    child: Image.asset('assets/unlock.png',fit: BoxFit.fill,),
                  )
                ],
              )
            )
          ),
          SizedBox(height: 10,)
        ]
      ),
    );
  }
  
}