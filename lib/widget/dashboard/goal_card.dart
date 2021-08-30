import 'package:flutter/material.dart';

class GoalCardWidget extends StatefulWidget {
  const GoalCardWidget({Key key}) : super(key: key);

  @override
  _GoalCardWidgetState createState() => _GoalCardWidgetState();
}

class _GoalCardWidgetState extends State<GoalCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Text(
            "-",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            "Boost connection with my Lady of the Light",
            style: TextStyle(
              fontSize: 20,
            ),
            softWrap: true,
          ),
        ),
        Icon(Icons.menu),
      ],
    );
  }
}
