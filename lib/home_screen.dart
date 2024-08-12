import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 10; //실수하지않지 않게 명확하기 위해 작성
  int totalSeconds = twentyFiveMinutes;
  late Timer timer;
  int totalPomodoros = 0;
  int timePomodoros = 0;
  bool isrunning = false;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        isrunning = false;
        totalPomodoros += 1;
        totalSeconds = 10;
        if (totalPomodoros % 5 == 0) {
          setState(() {
            timePomodoros += 1;
          });
        }
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isrunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isrunning = false;
    });
  }

  void reSetPressed() {
    timer.cancel();
    setState(() {
      totalSeconds = 10;
      isrunning = false;
      totalPomodoros = 0;
      timePomodoros = 0;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    print(duration); //0:25.00.000000
    print(duration.toString().split(".")); //[0:25:00, 000000]
    print(duration.toString().split(".").first); //0:25:00
    print(duration.toString().split(".").first.substring(2, 7)); //25:00
    return duration.toString().split('.').first.substring(2, 7); //25:00
  }

  void setTime(int seconds) {
    setState(() {
      isrunning = false;
      timer.cancel();
      totalSeconds = seconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: isrunning ? onPausePressed : onStartPressed,
                    icon: Icon(
                      isrunning
                          ? Icons.pause_circle_outline_outlined
                          : Icons.play_circle_outline_outlined,
                      size: 120,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  IconButton(
                    onPressed: reSetPressed,
                    icon: Icon(
                      Icons.restore_rounded,
                      size: 60,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  const SizedBox(height: 80),
                  Flexible(child: ListViewWidget(timeSelected: setTime)),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'POMODORO',
                              style: TextStyle(
                                letterSpacing: 1.0,
                                color: Color.fromARGB(255, 12, 13, 14),
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '$totalPomodoros',
                              style: const TextStyle(
                                fontSize: 58,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 17, 27, 75),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'TIME',
                              style: TextStyle(
                                letterSpacing: 1.0,
                                color: Color.fromARGB(255, 12, 13, 14),
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '$timePomodoros',
                              style: const TextStyle(
                                fontSize: 58,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 17, 27, 75),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListViewWidget extends StatefulWidget {
  final Function(int) timeSelected;
  const ListViewWidget({super.key, required this.timeSelected});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  List<Map<String, int>> setTime = [
    {"5:00": 300},
    {"10:00": 600},
    {"15:00": 900},
    {"20:00": 1200},
    {"25:00": 1500},
  ]; // List Map타입

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: setTime.length,
          itemBuilder: (context, index) {
            String timeLabel = setTime[index].keys.first;
            int timeValue = setTime[index].values.first;
            return Container(
              margin: const EdgeInsets.only(left: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).cardColor,
                ),
                onPressed: () {
                  widget.timeSelected(timeValue);
                },
                child: Text(
                  timeLabel,
                  style: TextStyle(
                    fontSize: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
