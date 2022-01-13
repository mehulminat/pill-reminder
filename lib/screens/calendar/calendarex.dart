import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../notifications/notifications.dart';
import '../../database/repository.dart';
import '../../models/pill.dart';
import '../../screens/home/medicines_list.dart';
import '../../screens/home/calendar.dart';
import '../../models/calendar_day_model.dart';

class CalendarEx extends StatefulWidget {
  @override
  _CalendarExState createState() => _CalendarExState();
}

class _CalendarExState extends State<CalendarEx> {
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

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - 60.0;
    // final double deviceHeight =
    // MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
}
/* 
 */
