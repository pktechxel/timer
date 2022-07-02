import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int hour = 0;
  int minute = 0;
  int second = 0;
  String timetodisplay = "";
  bool started = true;
  bool stopped = true;
  int timerval = 0;
  bool timercancel = false;

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    timerval = ((hour * 3600) + (minute * 60) + second);
    Timer.periodic(
      Duration(seconds: 1),
      (Timer t) {
        setState(() {
          if (timerval < 1 || timercancel == true) {
            t.cancel();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ),
            );
          } else {
            timerval = timerval - 1;
            timetodisplay = timerval.toString();
          }
        });
      },
    );
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      timercancel = true;
      timetodisplay = "";
    });
  }

  Widget timer() {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Text('HH'),
                    ),
                    NumberPicker(
                        minValue: 0,
                        maxValue: 23,
                        value: hour,
                        onChanged: (val) {
                          setState(() {
                            hour = val;
                          });
                        })
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Text('MM'),
                    ),
                    NumberPicker(
                        minValue: 0,
                        maxValue: 59,
                        value: minute,
                        onChanged: (val) {
                          setState(() {
                            minute = val;
                          });
                        })
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Text('SS'),
                    ),
                    NumberPicker(
                        minValue: 0,
                        maxValue: 59,
                        value: second,
                        onChanged: (val) {
                          setState(() {
                            second = val;
                          });
                        })
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(timetodisplay),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: started ? start : null,
                  child: Text('Start'),
                ),
                ElevatedButton(
                  onPressed: stopped ? null : stop,
                  child: Text('Stop'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.timer)),
                Tab(icon: Icon(Icons.timer_10)),
              ],
            ),
            title: const Text('Timer'),
          ),
          body: TabBarView(
            children: [
              timer(),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}
