import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pill_reminder/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pill_reminder/models/profile_model.dart';

class AddInfo extends StatefulWidget {
  @override
  _AddInfoState createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  File _image;
  String _imagepath;
  String name;
  String phoneno;
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    LoadImage();
    // LoadName();
    // LoadMobile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, // fluter 1.x
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
          child: Text(
            "Add Profile Information",
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: Colors.white),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Choose Profile Picture",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () async {
                    await PickImage();
                    await SaveImage(_image.path);
                    await LoadImage();
                  },
                  child: _imagepath != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(File(_imagepath)),
                          radius: 50.0,
                        )
                      : CircleAvatar(
                          radius: 50.0,
                          backgroundImage: _image != null
                              ? FileImage(_image)
                              : AssetImage('assets/onboard/temp_profile.png')),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            thickness: 2,
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                "Name:",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 1,
              ),
              SizedBox(height: 20),
              Text(
                "Phone No:",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 1,
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //refresh the pills from database
          print("fab pressed");
        },
        tooltip: "Add Medicines",
        child: Icon(Icons.done_outline_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.blueAccent,
          notchMargin: 6,
          clipBehavior: Clip.antiAlias,
          child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                height: 40,
              ))),
    );
  }

/* 
import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:user_profile_ii_example/model/user.dart';
import 'package:user_profile_ii_example/utils/user_preferences.dart';
import 'package:user_profile_ii_example/widget/appbar_widget.dart';
import 'package:user_profile_ii_example/widget/button_widget.dart';
import 'package:user_profile_ii_example/widget/profile_widget.dart';
import 'package:user_profile_ii_example/widget/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
        child: Builder(
          builder: (context) => Scaffold(
            appBar: buildAppBar(context),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: user.imagePath,
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: user.name,
                  onChanged: (name) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: user.email,
                  onChanged: (email) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'About',
                  text: user.about,
                  maxLines: 5,
                  onChanged: (about) {},
                ),
              ],
            ),
          ),
        ),
      );
} */
  void PickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void SaveImage(path) async {
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    saveImage.setString("imagepath", path);
  }

  void LoadImage() async {
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveImage.getString("imagepath");
    });
  }
}
