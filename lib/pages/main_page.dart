import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime selectedDateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day - DateTime.now().weekday + 1,
  );
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
                                setState(() {
                                  selectedDateTime = selectedDateTime.subtract(
                                    7.days,
                                  );
                                });
                              },
                              icon: Icon(Icons.arrow_back_ios),
                            ),
                            Text(
                              "W${(int.parse(DateFormat("D").format(selectedDateTime)) / 7).toInt()}",
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedDateTime = selectedDateTime.add(
                                    7.days,
                                  );
                                });
                              },
                              icon: Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          for (int i = 0; i < 7; i++)
                            Builder(
                              builder: (context) {
                                final DateTime ownDate = selectedDateTime.add(
                                  i.days,
                                );
                                return Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: BoxBorder.all(
                                        color: Get.theme.primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(DateFormat("E").format(ownDate)),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: 2,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          8.0,
                                                        ),
                                                    child: Container(
                                                      width: double.maxFinite,
                                                      height: 50,
                                                      color: Get
                                                          .theme
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ],
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
