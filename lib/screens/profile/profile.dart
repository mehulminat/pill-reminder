import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pill_reminder/screens/onboarding/addinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    LoadImage();
  }

  String _imagepath;
  String name;
  String phone;

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
                        child: Icon(Icons.arrow_forward_ios_rounded),
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
                          "Profile",
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
              CircleAvatar(
                backgroundImage: _imagepath != null
                    ? FileImage(File(_imagepath))
                    : AssetImage('assets/onboard/temp_profile.png'),
                radius: 50.0,
              ),
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
                "Name",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                textAlign: TextAlign.left,
              ),
              Text(this.name != null ? this.name : 'Reinstall'),
              Divider(
                indent: 20,
                thickness: 2,
                endIndent: 20,
                color: Colors.black,
              ),
              Text(
                "Phone No ",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                textAlign: TextAlign.left,
              ),
              Text(this.phone != null ? this.phone : 'Reinstall'),
            ],
          ),
        ),
      ),
    );
  }

  void LoadImage() async {
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveImage.getString("imagepath");
      name = saveImage.getString("username");
      phone = saveImage.getString("phone");
    });
  }
}
