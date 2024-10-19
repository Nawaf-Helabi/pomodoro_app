// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: Pomodoro(),
    );
  }
}

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  Timer? stop;
  Duration duration = Duration(minutes: 25);
  int number = 0;
  countDown() {
    stop = Timer.periodic(Duration(microseconds: 25), (timer) {
      setState(() {
        number = duration.inSeconds - 1;
        duration = Duration(seconds: number);
        if (number == 0) {
          stop!.cancel();
          duration = Duration(minutes: 25);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 40, 42),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 120,
                  progressColor: Color.fromARGB(255, 255, 47, 82),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  lineWidth: 10,
                  percent: duration.inMinutes/25,
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 1500,
                  center: Text(
                    '${duration.inMinutes.toString().padLeft(2, '0')} : ${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                    style: TextStyle(fontSize: 60, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      countDown();
                      setState(() {});
                    },
                    child: Text(
                      'Start timer',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.blueAccent)),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      stop!.cancel();
                    },
                    child: Text(
                      'Stop timer',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.redAccent)),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      stop!.cancel();
                      setState(() {
                        duration = Duration(minutes: 25);
                      });
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            const Color.fromARGB(255, 94, 45, 45))),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
