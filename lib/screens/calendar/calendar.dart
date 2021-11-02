import 'package:flutter/material.dart';

class CalendarHome extends StatefulWidget {
  @override
  _CalendarHomeState createState() => _CalendarHomeState();
}

class _CalendarHomeState extends State<CalendarHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("test"),
      appBar: AppBar(
        title: Text("Calendar"),
      ),
    );
  }
}
