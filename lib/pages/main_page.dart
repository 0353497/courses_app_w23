import 'package:flutter/material.dart';
import 'package:courses_app/models/course.dart';
import 'package:courses_app/services/http_service.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late DateTime selectedDateTime;
  late Future<List<Course>> coursesFuture;

  @override
  void initState() {
    super.initState();
    selectedDateTime = _weekStart(DateTime(2025, 5));
    coursesFuture = _loadCourses();
  }

  DateTime _weekStart(DateTime date) {
    final start = DateTime(
      date.year,
      date.month,
      date.day,
    ).subtract(Duration(days: date.weekday - 1));
    return DateTime(start.year, start.month, start.day);
  }

  Future<List<Course>> _loadCourses() {
    final start = _weekStart(selectedDateTime);
    final end = start.add(const Duration(days: 7));
    return HttpService.getCourses(start, end);
  }

  void _changeWeek(int offsetDays) {
    setState(() {
      selectedDateTime = selectedDateTime.add(Duration(days: offsetDays));
      coursesFuture = _loadCourses();
    });
  }

  List<Course> _coursesForDay(List<Course> courses, DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return courses.where((course) {
      final courseDay = DateTime(
        course.start.year,
        course.start.month,
        course.start.day,
      );
      return courseDay == normalizedDay;
    }).toList()..sort((left, right) => left.start.compareTo(right.start));
  }

  Widget _buildCourseTile(Course course) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("VierToreGym Courses"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("sign out"),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat("yyyy/M/d").format(selectedDateTime)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 12,
                          children: [
                            IconButton(
                              onPressed: () {
                                _changeWeek(-7);
                              },
                              icon: Icon(Icons.arrow_back_ios),
                            ),
                            Text(
                              "W${(int.parse(DateFormat("D").format(selectedDateTime)) / 7).toInt()}",
                            ),
                            IconButton(
                              onPressed: () {
                                _changeWeek(7);
                              },
                              icon: Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: FutureBuilder<List<Course>>(
                        future: coursesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError) {
                            return const Center(child: Text('error'));
                          }

                          final courses = snapshot.data ?? const <Course>[];

                          return Row(
                            children: [
                              for (int i = 0; i < 7; i++)
                                Builder(
                                  builder: (context) {
                                    final DateTime ownDate = selectedDateTime
                                        .add(i.days);
                                    final dayCourses = _coursesForDay(
                                      courses,
                                      ownDate,
                                    );

                                    return Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Get.theme.primaryColor,
                                            width: 2,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Text(
                                                DateFormat('E').format(ownDate),
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                    ),
                                                itemCount: dayCourses.length,
                                                itemBuilder: (context, index) {
                                                  return _buildCourseTile(
                                                    dayCourses[index],
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Title"),
                        Image.network(
                          "",
                          errorBuilder: (context, error, stackTrace) {
                            return Center(child: Icon(Icons.error));
                          },
                        ),
                      ],
                    ),
                    Text("Description"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
