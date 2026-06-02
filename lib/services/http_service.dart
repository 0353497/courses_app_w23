import 'dart:convert';

import 'package:courses_app/models/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HttpService {
  static Future<List<Course>> getCourses(DateTime start, DateTime end) async {
    final String startValue = DateFormat("yyyy/MM/d").format(start);
    final String endValue = DateFormat("yyyy/MM/d").format(end);
    debugPrint(
      "calling api http://192.168.0.100:8080/api/course?start=$startValue&end=$endValue",
    );
    final res = await http.get(
      Uri.parse(
        "http://10.0.2.2:8080/api/course?start=$startValue&end=$endValue",
      ),
    );
    final data = jsonDecode(res.body);
    final List courses = data["result"];
    return courses.map((course) => Course.fromJson(course)).toList();
  }
}
