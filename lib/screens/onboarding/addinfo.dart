import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

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
      resizeToAvoidBottomInset: true,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: ClampingScrollPhysics(),
        child: Column(
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
                                : AssetImage(
                                    'assets/onboard/temp_profile.png')),
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
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  maxLines: 1,
                ),
                SizedBox(height: 10),
                Text(
                  "Phone No:",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //refresh the pills from database
          print("fab pressed");
          SharedPreferences saveName = await SharedPreferences.getInstance();
          saveName.setString("username", nameController.text);
          SharedPreferences savePhone = await SharedPreferences.getInstance();
          savePhone.setString("phone", phoneController.text);
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => Home(),
              // transitionDuration: Duration(milliseconds: 350),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
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
