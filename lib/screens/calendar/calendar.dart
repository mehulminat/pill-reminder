import 'package:flutter/material.dart';

class CalendarHome extends StatefulWidget {
  @override
  _CalendarHomeState createState() => _CalendarHomeState();
}

class _CalendarHomeState extends State<CalendarHome> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - 60.0;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 30.0, bottom: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: deviceHeight * 0.04,
                    child: FittedBox(
                      child: InkWell(
                        child: Icon(Icons.arrow_back_ios_outlined),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0),
                    height: deviceHeight * 0.05,
                    child: FittedBox(
                        alignment: Alignment.center,
                        child: Text(
                          "Calendar",
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(color: Colors.black),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Calendar Screen"),
              SizedBox(
                height: 20.0,
              ),
              Divider(
                indent: 20,
                thickness: 2,
                endIndent: 20,
                color: Colors.black,
              ),
              Text(
                "Calendar Info ",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
