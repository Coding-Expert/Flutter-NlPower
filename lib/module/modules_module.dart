import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nlpower/model/modules.dart';
import 'package:nlpower/service/firebase_service.dart';
import 'package:http/http.dart' as http;

class ModulesModule {
  static Modules modules;

  static Future<Modules> getModules() async {
    final user = await FirebaseService.auth.getCurrentUser();
    var body = jsonEncode({
      "key": "-vaudSGntDBhFM^+M!67EE2FwytZDKPrrxXFq?@B+wqbGtHMRZV-LDeq%AnQ9pD4vdTF7QYUgbp?ZbGy*^gAuKrC-q9#qguAJP",
      "oauth_uid": user.uid,
      "level": 1,
      "week": 0,
    });
    var response = await http.post(
      Uri.parse("https://app.metamathesis.edu.gr/bridge/get_modules"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      modules = Modules.fromJson(res);
    }
    return modules;
  }
}
