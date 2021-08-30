import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nlpower/model/modules.dart';
import 'package:nlpower/module/modules_module.dart';
import 'package:nlpower/service/firebase_service.dart';
import 'package:nlpower/widget/dashboard/card_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ModulesPage extends StatefulWidget {
  ModulesPageState createState() => ModulesPageState();
}

class ModulesPageState extends State<ModulesPage> {
  Modules modules;
  bool loading = false;

  Future<void> getModules() async {
    setState(() {
      loading = true;
    });
    await ModulesModule.getModules().then((module) {
      if (module != null) {
        setState(() {
          modules = module;
          loading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getModules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modules"),
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
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/gym_back.png"),
                      fit: BoxFit.cover)),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: modules.modules
                    .map((item) => DashboardCardWidget(
                          title: item.module_title,
                          description: item.description,
                          completePercent: 100,
                          time: item.total_time,
                          media: item.media,
                        ))
                    .toList(),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
