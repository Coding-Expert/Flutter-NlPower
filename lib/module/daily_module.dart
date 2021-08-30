import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nlpower/model/common_day.dart';
import 'package:nlpower/model/day.dart';
import 'package:nlpower/model/group.dart';
import 'package:nlpower/model/item_detail.dart';
import 'package:nlpower/model/week.dart';
import 'package:nlpower/module/user_module.dart';

class DailyModule {
  static Week week;
  static List<CommonDay> commonday_list = [];
  static int total;
  static int score;
  static double percent;

  static Future<Week> getDaily(int m_level, int m_week, int m_day) async {
    var body = jsonEncode({
      "key":
          "-vaudSGntDBhFM^+M!67EE2FwytZDKPrrxXFq?@B+wqbGtHMRZV-LDeq%AnQ9pD4vdTF7QYUgbp?ZbGy*^gAuKrC-q9#qguAJP",
      "oauth_uid": UserModule.user.uid,
      "level": m_level,
      "week": m_week,
      "day": m_day
    });
    var response = await http.post(
      Uri.parse("https://app.metamathesis.edu.gr/bridge/get_daily"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      List week_list = res["weeks"];
      if (week_list.length > 0) {
        week = Week.fromJson(week_list[0]);
      }
    }
    return week;
  }

  static Future<String> setTracking(
      String day, String media_id, String duration) async {
    String result = "";
    var body = jsonEncode({
      "key":
          "-vaudSGntDBhFM^+M!67EE2FwytZDKPrrxXFq?@B+wqbGtHMRZV-LDeq%AnQ9pD4vdTF7QYUgbp?ZbGy*^gAuKrC-q9#qguAJP",
      "oauth_uid": UserModule.user.uid,
      "day": int.parse(day),
      "media_id": int.parse(media_id),
      "duration": int.parse(duration)
    });
    var response = await http.post(
      Uri.parse("https://app.metamathesis.edu.gr/bridge/set_tracking"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      if (res["message"] == "success") {
        result = res["message"];
      }
    }
    return result;
  }

  static Future<List<CommonDay>> getAllDay() async {
    commonday_list = [];
    var body = jsonEncode({
      "key":
          "-vaudSGntDBhFM^+M!67EE2FwytZDKPrrxXFq?@B+wqbGtHMRZV-LDeq%AnQ9pD4vdTF7QYUgbp?ZbGy*^gAuKrC-q9#qguAJP",
      "oauth_uid": UserModule.user.uid,
    });
    var response = await http.post(
      Uri.parse("https://app.metamathesis.edu.gr/bridge/get_all"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List res = jsonDecode(response.body);
      if (res.length > 0) {
        for (int i = 0; i < res.length; i++) {
          commonday_list.add(CommonDay.fromJson(res[i]));
        }
      }
    }
    return commonday_list;
  }

  static Future<String> getTracking() async {
    String result = "";
    var body = jsonEncode({
      "key": "-vaudSGntDBhFM^+M!67EE2FwytZDKPrrxXFq?@B+wqbGtHMRZV-LDeq%AnQ9pD4vdTF7QYUgbp?ZbGy*^gAuKrC-q9#qguAJP",
      "oauth_uid": "firebase_auth_code",//UserModule.user.uid,
      "day": 2,
      "week": 1
    });
    var response = await http.post(
      Uri.parse("https://app.metamathesis.edu.gr/bridge/get_tracking"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      var totals = res["totals"];
      List week_list = res["weekly"];
      
      score = totals["score"];
      total = totals["totals"];
      percent = double.parse(week_list[0]["percentage"]);
    }
    return result;
  }
  
  static Future<String> sendAnswer(String question) async {
    String result = "";
    var body = jsonEncode({
      "key": "-vaudSGntDBhFM^+M!67EE2FwytZDKPrrxXFq?@B+wqbGtHMRZV-LDeq%AnQ9pD4vdTF7QYUgbp?ZbGy*^gAuKrC-q9#qguAJP",
      "oauth_uid": UserModule.user.uid,
      "questions": question,
      
    });
    var response = await http.post(
      Uri.parse("https://app.metamathesis.edu.gr/bridge/save_answer"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      result = "success";
      print("------result:${result}");
    }
    return result;
  }
}
