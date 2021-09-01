

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
  int question_index = 0;
  List<String> answer_list = [];

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
        // focus_list.add(new FocusNode());
        // textEdit_list.add(new TextEditingController());
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
              // for(var id in questionId_list)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                  children:[
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Q:', style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(widget.group.item_details[question_index].question_title, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold), maxLines: 3,)
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: TextField(
                        focusNode: myFocusNodeAnswer,
                        controller: answerController,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(fontFamily: "WorkSansSemiBold",fontSize: 16.0,color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Answer' + (question_index + 1).toString(),
                        ),
                        maxLines: 4,
                      )
                    )
                  ]
                )
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    onPressed: () {
                      answer_list.add(answerController.text);
                      answerController.text = "";
                      if(question_index == questionId_list.length - 1){
                        onSendAnswer();
                      }
                      else{
                        setState(() {
                          question_index = question_index + 1;                 
                        });
                      }
                      
                    },
                    child: Text(question_index != questionId_list.length - 1 ? 'NEXT' : 'SEND', style: TextStyle(fontSize: 18),),
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
        "answer": answer_list[i]
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