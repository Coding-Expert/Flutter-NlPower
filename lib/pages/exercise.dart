

import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget{

  ExercisePageState createState()=> ExercisePageState();
}

class ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Exercise Page', style:TextStyle(color: Colors.black)),
      ),
    );
  }
  
}