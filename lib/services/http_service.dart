import 'dart:convert';

import 'package:courses_app/models/course.dart';
import 'package:courses_app/models/detail_course.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HttpService {
  static Future<List<Course>> getCourses(DateTime start, DateTime end) async {
    final String startValue = DateFormat("yyyy/MM/d").format(start);
    final String endValue = DateFormat("yyyy/MM/d").format(end);

    final res = await http.get(
      Uri.parse(
        "http://10.0.2.2:8080/api/course?start=$startValue&end=$endValue",
      ),
    );
    final data = jsonDecode(res.body);
    final List courses = data["result"];
    return courses.map((course) => Course.fromJson(course)).toList();
  }

  static Future<DetailCourse> getCourseById(int id) async {
    final res = await http.get(
      Uri.parse("http://10.0.2.2:8080/api/course/$id"),
    );
    final data = jsonDecode(res.body);
    return DetailCourse.fromJson(data["result"]);
  }

  static Future<bool> login(String username, String password) async {
    final res = await http.post(
      Uri.parse("http://10.0.2.2:8080/api/auth/login"),
      body: {"username": username, "password": password},
    );
    final data = jsonDecode(res.body);
    return data["succes"];
  }
}
