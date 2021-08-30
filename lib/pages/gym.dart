import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nlpower/widget/card_group.dart';
import 'package:http/http.dart' as http;

class GymPage extends StatefulWidget {
  GymPageState createState() => GymPageState();
}

class GymPageState extends State<GymPage> {
  // Declare variables
  List<Map<String, dynamic>> categories = [];
  bool loading = true;

  // Declare functions
  Future<void> getCategories() async {
    await dotenv.load(fileName: ".env");
    final body = jsonEncode({
      "key": dotenv.env['API_KEY'],
      "code": "category_label_gym",
      "lang": "el"
    });
    final list = await http.post(
      Uri.parse('https://app.metamathesis.edu.gr/bridge/media_list'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    final jsonData = jsonDecode(list.body);
    List listItems = jsonData['items'];
    setState(() {
      for (var item in listItems) {
        categories.add({'label': item['label'], 'media': item['media']});
      }
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gym"),
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
      body: loading == false
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/gym_back.png"),
                      fit: BoxFit.cover)),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: categories.map(
                  (item) {
                    return CardGroupWidget(
                      groupTitle: item['label'],
                      medias: item['media'],
                    );
                  },
                ).toList(),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
