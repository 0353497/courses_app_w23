import 'dart:convert';

import 'package:courses_app/models/course.dart';
import 'package:courses_app/models/detail_course.dart';
import 'package:courses_app/providers/user_provider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HttpService {
  static const String _baseUrl = "http://10.0.2.2:8080";

  static Map<String, String> get _authHeaders {
    final token = Get.find<UserProvider>().token.value;
    if (token.isEmpty) return const {};

    return {"Authorization": "Bearer $token"};
  }

  static Future<List<Course>> getCourses(DateTime start, DateTime end) async {
    final String startValue = DateFormat("yyyy/MM/d").format(start);
    final String endValue = DateFormat("yyyy/MM/d").format(end);

    final res = await http.get(
      Uri.parse("$_baseUrl/api/course?start=$startValue&end=$endValue"),
      headers: _authHeaders,
    );
    final data = jsonDecode(res.body);
    final List courses = data["result"];
    return courses.map((course) => Course.fromJson(course)).toList();
  }

  static Future<DetailCourse> getCourseById(int id) async {
    final res = await http.get(
      Uri.parse("$_baseUrl/api/course/$id"),
      headers: _authHeaders,
    );
    final data = jsonDecode(res.body);
    return DetailCourse.fromJson(data["result"]);
  }

  static Future<void> bookCourse(int courseId) async {
    await http.post(
      Uri.parse("$_baseUrl/api/course/$courseId/booking"),
      headers: _authHeaders,
    );
  }

  static Future<void> removeBooking(int courseId) async {
    await http.delete(
      Uri.parse("$_baseUrl/api/course/$courseId/booking"),
      headers: _authHeaders,
    );
  }

  static Future<dynamic> getSession() async {
    final res = await http.get(
      Uri.parse("$_baseUrl/api/auth/session"),
      headers: _authHeaders,
    );
    return jsonDecode(res.body);
  }

  static Future<void> signOut() async {
    await http.delete(
      Uri.parse("$_baseUrl/api/auth/signout"),
      headers: _authHeaders,
    );
  }

  static Future<dynamic> login(String username, String password) async {
    final res = await http.post(
      Uri.parse("$_baseUrl/api/auth/login"),
      body: {"username": username, "password": password},
    );
    final data = jsonDecode(res.body);
    return data;
  }
}
