import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../notifications/notifications.dart';
import '../../database/repository.dart';
import '../../models/pill.dart';
import '../../screens/home/medicines_list.dart';
import '../../screens/home/calendar.dart';
import '../../models/calendar_day_model.dart';
import 'package:pill_reminder/screens/profile/profile.dart';
import 'package:pill_reminder/screens/calendar/calendarex.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File _image;
  String _imagepath;
  String username;
  //-------------------| Flutter notifications |-------------------
  final Notifications _notifications = Notifications();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  //===============================================================

  //--------------------| List of Pills from database |----------------------
  List<Pill> allListOfPills = List<Pill>();
  final Repository _repository = Repository();
  List<Pill> dailyPills = List<Pill>();
  //=========================================================================

  //-----------------| Calendar days |------------------
  final CalendarDayModel _days = CalendarDayModel();
  List<CalendarDayModel> _daysList;
  //====================================================

  //handle last choose day index in calendar
  int _lastChooseDay = 0;

  @override
  void initState() {
    super.initState();
    initNotifies();
    setData();
    LoadImage();
    LoadUserData();
    _daysList = _days.getCurrentDays();
  }

  //init notifications
  Future initNotifies() async => flutterLocalNotificationsPlugin =
      await _notifications.initNotifies(context);

  //--------------------GET ALL DATA FROM DATABASE---------------------
  Future setData() async {
    allListOfPills.clear();
    (await _repository.getAllData("Pills")).forEach((pillMap) {
      allListOfPills.add(Pill().pillMapToObject(pillMap));
    });
    chooseDay(_daysList[_lastChooseDay]);
  }
  //===================================================================

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //refresh the pills from database
          await Navigator.pushNamed(context, "/add_new_medicine")
              .then((_) => setData());
        },
        tooltip: "Add Medicines",
        child: Icon(Icons.add_circle_sharp),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.blueAccent,
          notchMargin: 6,
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  padding: EdgeInsets.all(2.0),
                  onPressed: () {
                    // print("calneder");
                    // (Navigator.of(context).pushNamed('calendar'));
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => CalendarEx(),
                        // transitionDuration: Duration(milliseconds: 350),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(-1.0, 0.0);
                          const end = Offset(0.0, 0.0);
                          final tween = Tween(begin: begin, end: end);
                          final offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  icon: Icon(Icons.calendar_today_rounded, color: Colors.white),
                  iconSize: 30.0,
                ),
                SizedBox(
                  width: 1.0,
                ),
                IconButton(
                  padding: EdgeInsets.all(2.0),
                  onPressed: () {
                    // print("person");
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => Profile(),
                        // transitionDuration: Duration(milliseconds: 350),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          final tween = Tween(begin: begin, end: end);
                          final offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  icon: Icon(Icons.person, color: Colors.white),
                  iconSize: 30.0,
                ),
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                top: 0.0, left: 25.0, right: 25.0, bottom: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: deviceHeight * 0.1,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: deviceHeight * 0.1,
                          width: deviceWidth * 0.7,
                          child: Stack(
                            children: [
                              Text(
                                "Hi,",
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 12),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 1,
                                child: Text(
                                  username != null ? username : 'Mehul',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (c, a1, a2) => Profile(),
                                transitionDuration: Duration(milliseconds: 350),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  final tween = Tween(begin: begin, end: end);
                                  final offsetAnimation =
                                      animation.drive(tween);
                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: _imagepath != null
                              ? CircleAvatar(
                                  backgroundImage: FileImage(File(_imagepath)),
                                  radius: 20.0,
                                )
                              : CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: _image != null
                                      ? AssetImage(
                                          'assets/onboard/emp_profile.png')
                                      : null),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Calendar(chooseDay, _daysList),
                ),
                SizedBox(height: deviceHeight * 0.03),
                dailyPills.isEmpty
                    ? SizedBox(
                        // width: deviceWidth,
                        height: 400,
                        child: OverflowBox(
                          maxHeight: 700,
                          maxWidth: 600,
                          child: Lottie.asset(
                            'assets/lottieanim/nodata_anim.json',
                            repeat: true,
                            reverse: true,
                            alignment: Alignment.center,
                            // width: 50.0,
                          ),
                        ),
                      )
                    : MedicinesList(
                        dailyPills, setData, flutterLocalNotificationsPlugin)
              ],
            ),
          ),
        ),
      ),
    );
  }

  //-------------------------| Click on the calendar day |-------------------------

  void chooseDay(CalendarDayModel clickedDay) {
    setState(() {
      _lastChooseDay = _daysList.indexOf(clickedDay);
      _daysList.forEach((day) => day.isChecked = false);
      CalendarDayModel chooseDay = _daysList[_daysList.indexOf(clickedDay)];
      chooseDay.isChecked = true;
      dailyPills.clear();
      allListOfPills.forEach((pill) {
        DateTime pillDate =
            DateTime.fromMicrosecondsSinceEpoch(pill.time * 1000);
        if (chooseDay.dayNumber == pillDate.day &&
            chooseDay.month == pillDate.month &&
            chooseDay.year == pillDate.year) {
          dailyPills.add(pill);
        }
      });
      dailyPills.sort((pill1, pill2) => pill1.time.compareTo(pill2.time));
    });
  }

  //===============================================================================
  void LoadImage() async {
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveImage.getString("imagepath");
    });
  }

  void LoadUserData() async {
    SharedPreferences saveName = await SharedPreferences.getInstance();
    setState(() {
      username = saveName.getString("username");
    });
  }
}
