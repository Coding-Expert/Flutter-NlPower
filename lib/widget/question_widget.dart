

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nlpower/model/group.dart';
import 'package:nlpower/module/daily_module.dart';
import 'package:toast/toast.dart';

class QuestionWidget extends StatefulWidget {

  final Group group;
  QuestionWidget({
    Key key,
    this.group
  }): super(key: key);

  QuestionWidgetState createState()=> QuestionWidgetState();
}

class QuestionWidgetState extends State<QuestionWidget> {

  final FocusNode myFocusNodeAnswer = FocusNode();
  TextEditingController answerController = new TextEditingController();
  List<int> questionId_list = [];
  List<FocusNode> focus_list = [];
  List<TextEditingController> textEdit_list = [];
  final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

  @override
  void initState() {
    super.initState();
    getQuestionIdList();
  }

  void getQuestionIdList(){
    for(int i = 0; i < widget.group.question_id.length; i++){
      String char = widget.group.question_id.substring(i, i+1);
      if(numericRegex.hasMatch(char)){
        questionId_list.add(int.parse(char));
        focus_list.add(new FocusNode());
        textEdit_list.add(new TextEditingController());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reflections'),
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Q:', style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(widget.group.item_details.question_title, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold))
                    )
                  ],
                ),
              ),
              for(var id in questionId_list)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    focusNode: focus_list[questionId_list.indexOf(id)],//myFocusNodeAnswer,
                    controller: textEdit_list[questionId_list.indexOf(id)], //answerController,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontFamily: "WorkSansSemiBold",fontSize: 16.0,color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Answer' + (questionId_list.indexOf(id) + 1).toString(),
                    ),
                    maxLines: 4,
                  )
                ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    onPressed: () {
                      onSendAnswer();
                    },
                    child: Text('NEXT', style: TextStyle(fontSize: 18),),
                    textColor: Colors.black,
                    color: Colors.grey.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        ),
                    elevation: 0,
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }

  void onSendAnswer(){
    List<Map<String, dynamic>> json_array = [];
    for(int i = 0; i < questionId_list.length; i++){
      var data = {
        "question_id": questionId_list[i],
        "answer": textEdit_list[i].text
      };
      json_array.add(data);
    }
    String questions = jsonEncode(json_array);
    DailyModule.sendAnswer(questions).then((value) {
      if(value == "success"){
        Toast.show("Answer have sent successfully!", context);
      }
    });
  }

}