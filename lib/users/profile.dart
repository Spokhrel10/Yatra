// ignore_for_file: unnecessary_new

import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/helpers/ui_helper.dart';
import '../controllers/signup_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FourthRoute extends StatefulWidget {
  final String userId;
  const FourthRoute({Key? key, required this.userId}) : super(key: key);

  @override
  State<FourthRoute> createState() => _FourthRouteState();
}

class _FourthRouteState extends State<FourthRoute> {
  final _storage = const FlutterSecureStorage();
  var isLoading = true;
  String username = "";
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String locat = "";
  File? _imagePath;
  String emailing = "";
  String phonenumber = "";
  String gen = "";
  String aging = "";
  String dobing = "";
  SignUpController signUpController = Get.put(SignUpController());
  SignUpController signUp = Get.find();

  @override
  void initState() {
    super.initState();
    _getSavedData();
    login();
  }

  Future<void> login() async {
    final snapshot = await db.collection("users").get();
    final users = snapshot.docs
        .map((doc) => doc.data())
        .where((owner) => owner["email"] == emailing)
        .toList();

    if (users.length == 1) {
      final user = users.first;
      final fullName = user["full_name"];
      final location = user["location"];
      final email = user["email"];
      final phoneNumber = user["phone_number"];
      final gender = user["gender"];
      final age = user["age"];
      final dob = user["dob"].toString();

      await _storage.write(key: 'full_name', value: fullName);
      await _storage.write(key: 'location', value: location);
      await _storage.write(key: 'email', value: email);
      await _storage.write(key: 'phone_number', value: phoneNumber.toString());
      await _storage.write(key: 'gender', value: gender);
      await _storage.write(key: 'age', value: age.toString());
      await _storage.write(key: 'dob', value: dob);

      setState(() {
        username = fullName;
        locat = location;
        emailing = email;
        phonenumber = phoneNumber;
        gen = gender;
        aging = age.toString();
        dobing = dob;

        isLoading = false;
      });
    } else {
      final invalidCredentialsErrorBar = SnackBar(
        content: Text(
          "Invalid email or password!",
          style: TextStyle(
            color: Colors.grey.shade900,
            fontSize: 17,
            fontFamily: 'OpenSans',
          ),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(milliseconds: 3000),
        backgroundColor: Colors.red.shade400,
      );
      ScaffoldMessenger.of(context).showSnackBar(invalidCredentialsErrorBar);
    }
  }

  void _getSavedData() async {
    final email = await _storage.read(key: 'email');

    setState(() {
      emailing = email!;

      isLoading = false;
    });
  }

  Future<File?> _getImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/profile_image.png';

      // Save the image file to the directory
      final savedFile = await File(pickedFile.path).copy(imagePath);

      // Save the image path to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('imagePath', savedFile.path);

      return savedFile;
    }
    return null;
  }

  Future<File?> _getImageFromGallery() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/profile_image.png';

      // Save the image file to the directory
      final savedFile = await File(pickedFile.path).copy(imagePath);

      // Save the image path to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('imagePath', savedFile.path);

      return savedFile;
    }
    return null;
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a photo'),
                  onTap: () async {
                    final imageFile = await _getImageFromCamera();
                    if (imageFile != null) {
                      _imagePath = imageFile;
                      signUp.setProfileImagePath(_imagePath!.path);
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from gallery'),
                  onTap: () async {
                    final imageFile = await _getImageFromGallery();
                    if (imageFile != null) {
                      _imagePath = imageFile;
                      signUp.setProfileImagePath(_imagePath!.path);
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    // Retrieve saved image path from SharedPreferences and set it to _imagePath
    final prefs = await SharedPreferences.getInstance();
    final savedImagePath = prefs.getString('imagePath');
    if (savedImagePath != null) {
      _imagePath = File(savedImagePath);
      signUp.setProfileImagePath(_imagePath!.path);
    }
  }

  var size, height, width;
  var circular = true;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  String creditBalance = "0.00";

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0062DE),
          centerTitle: true,
          title: const Text('Profile',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: 'Roboto Bold',
                fontSize: 22,
                height: 1.19,
                fontWeight: FontWeight.w500,
              )),
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFFFFFFFF),
                  size: 25,
                ),
                onPressed: () {
                  Get.back();
                },
              );
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Color(0xFF0062DE),
                  )
                : Column(children: [
                    Expanded(
                      child: SingleChildScrollView(
                          child: SizedBox(
                              width: UiHelper.displayWidth(context) * 1,
                              height: UiHelper.displayHeight(context) * 1,
                              child: CustomPaint(
                                painter: CurvePainter(),
                                child: Column(
                                  children: [
                                    SizedBox(height: 2.4.h),
                                    badges.Badge(
                                        position:
                                            badges.BadgePosition.bottomEnd(
                                                bottom: 3, end: 3),
                                        showBadge: true,
                                        ignorePointer: false,
                                        onTap: () {
                                          _pickImage();
                                        },
                                        badgeContent: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.white,
                                            size: 16.5.sp),
                                        badgeAnimation: const badges
                                            .BadgeAnimation.rotation(
                                          animationDuration:
                                              Duration(seconds: 1),
                                          colorChangeAnimationDuration:
                                              Duration(seconds: 1),
                                          loopAnimation: false,
                                          curve: Curves.fastOutSlowIn,
                                          colorChangeAnimationCurve:
                                              Curves.easeInCubic,
                                        ),
                                        badgeStyle: badges.BadgeStyle(
                                          badgeColor: const Color(0xFF0062DE),
                                          padding: const EdgeInsets.all(5),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFFFFFFF),
                                              width: 1.8),
                                          elevation: 0,
                                        ),
                                        child: Obx(() {
                                          if (_imagePath != null) {
                                            return CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage:
                                                  FileImage(_imagePath!),
                                              radius: 30.sp,
                                            );
                                          } else if (signUp
                                                  .isProficPicPathSet.value ==
                                              true) {
                                            return CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: FileImage(File(
                                                  signUp.profilePicPath.value)),
                                              radius: 30.sp,
                                            );
                                          } else {
                                            const defaultImagePath =
                                                'images/hello.jpg';
                                            return CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: const AssetImage(
                                                  defaultImagePath),
                                              radius: 30.sp,
                                            );
                                          }
                                        })),
                                    SizedBox(height: 1.h),
                                    Text(
                                      username,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: height / 305,
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFFFFFFF),
                                          fontSize: width * 0.077),
                                    ),
                                    UiHelper.verticalSpace(
                                        vspace: Spacing.medium),
                                    SizedBox(
                                      width: 44.5.w,
                                      height: 6.5.h,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                              0xfffffffff), //background color of button
                                          //border width and color

                                          shape: RoundedRectangleBorder(
                                              //to set border radius to button
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/line11');
                                        },
                                        child: Text("EDIT PROFILE",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunito(
                                                height: 0.165.h,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xFF0062DE),
                                                fontSize: 18.5.sp)),
                                      ),
                                    ),
                                    UiHelper.verticalSpace(
                                        vspace: Spacing.medium),
                                    Container(
                                      height: 58.h,
                                      width:
                                          UiHelper.displayWidth(context) * 0.83,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFFFFF),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            offset: const Offset(0, 8),
                                            blurRadius: 10.0,
                                            spreadRadius: 0.0,
                                          ), //BoxShadow
                                          //BoxShadow
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          UiHelper.verticalSpace(
                                              vspace: Spacing.medium),
                                          Row(
                                            children: [
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.large),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Icon(
                                                    Icons.location_on_rounded,
                                                    size: UiHelper.displayWidth(
                                                            context) *
                                                        0.065,
                                                    color:
                                                        const Color(0xFF0062DE),
                                                  )),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.medium),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Address',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      letterSpacing: 0.3,
                                                      fontFamily: "KumbhSans",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xFF222222),
                                                      fontSize:
                                                          UiHelper.displayWidth(
                                                                  context) *
                                                              0.043),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xxlarge),
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xlarge),
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xsmall),
                                                  Align(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      width: width * 0.65,
                                                      height: height * 0.03,
                                                      child: Text(
                                                        locat,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            letterSpacing: 0.1,
                                                            fontFamily:
                                                                "SignikaNegative-Bold",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: const Color(
                                                                0xFFA6AEB0),
                                                            fontSize: UiHelper
                                                                    .displayWidth(
                                                                        context) *
                                                                0.04),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.000090,
                                          ),
                                          UiHelper.verticalSpace(
                                              vspace: Spacing.medium),
                                          Row(
                                            children: [
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.large),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Icon(
                                                    Icons.mail_rounded,
                                                    size: UiHelper.displayWidth(
                                                            context) *
                                                        0.065,
                                                    color:
                                                        const Color(0xFF0062DE),
                                                  )),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.medium),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Email Address',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      letterSpacing: 0.3,
                                                      fontFamily: "KumbhSans",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xFF222222),
                                                      fontSize:
                                                          UiHelper.displayWidth(
                                                                  context) *
                                                              0.043),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xxlarge),
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xlarge),
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xsmall),
                                                  Align(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      width: width * 0.65,
                                                      height: height * 0.03,
                                                      child: Text(
                                                        emailing,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            letterSpacing: 0.1,
                                                            fontFamily:
                                                                "SignikaNegative-Bold",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: const Color(
                                                                0xFFA6AEB0),
                                                            fontSize: UiHelper
                                                                    .displayWidth(
                                                                        context) *
                                                                0.04),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.000090,
                                          ),
                                          UiHelper.verticalSpace(
                                              vspace: Spacing.medium),
                                          Row(
                                            children: [
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.large),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Icon(
                                                    Icons.phone_rounded,
                                                    size: UiHelper.displayWidth(
                                                            context) *
                                                        0.065,
                                                    color:
                                                        const Color(0xFF0062DE),
                                                  )),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.medium),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Mobile Number',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      letterSpacing: 0.3,
                                                      fontFamily: "KumbhSans",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xFF222222),
                                                      fontSize:
                                                          UiHelper.displayWidth(
                                                                  context) *
                                                              0.043),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xxlarge),
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xlarge),
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xsmall),
                                                  Align(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      width: width * 0.65,
                                                      height: height * 0.03,
                                                      child: Text(
                                                        phonenumber,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            letterSpacing: 0.1,
                                                            fontFamily:
                                                                "SignikaNegative-Bold",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: const Color(
                                                                0xFFA6AEB0),
                                                            fontSize: UiHelper
                                                                    .displayWidth(
                                                                        context) *
                                                                0.04),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.000090,
                                          ),
                                          UiHelper.verticalSpace(
                                              vspace: Spacing.medium),
                                          Row(
                                            children: [
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.large),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Icon(
                                                    Icons.person,
                                                    size: UiHelper.displayWidth(
                                                            context) *
                                                        0.065,
                                                    color:
                                                        const Color(0xFF0062DE),
                                                  )),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.medium),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Gender',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      letterSpacing: 0.3,
                                                      fontFamily: "KumbhSans",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xFF222222),
                                                      fontSize:
                                                          UiHelper.displayWidth(
                                                                  context) *
                                                              0.043),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xxlarge),
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xlarge),
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xsmall),
                                                  Align(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      width: width * 0.65,
                                                      height: height * 0.03,
                                                      child: Text(
                                                        gen,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            letterSpacing: 0.1,
                                                            fontFamily:
                                                                "SignikaNegative-Bold",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: const Color(
                                                                0xFFA6AEB0),
                                                            fontSize: UiHelper
                                                                    .displayWidth(
                                                                        context) *
                                                                0.04),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.000090,
                                          ),
                                          UiHelper.verticalSpace(
                                              vspace: Spacing.medium),
                                          Row(
                                            children: [
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.large),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Icon(
                                                    Icons.face,
                                                    size: UiHelper.displayWidth(
                                                            context) *
                                                        0.065,
                                                    color:
                                                        const Color(0xFF0062DE),
                                                  )),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.medium),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Age',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      letterSpacing: 0.3,
                                                      fontFamily: "KumbhSans",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xFF222222),
                                                      fontSize:
                                                          UiHelper.displayWidth(
                                                                  context) *
                                                              0.043),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xxlarge),
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xlarge),
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xsmall),
                                                  Align(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      width: width * 0.65,
                                                      height: height * 0.03,
                                                      child: Text(
                                                        aging,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            letterSpacing: 0.1,
                                                            fontFamily:
                                                                "SignikaNegative-Bold",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: const Color(
                                                                0xFFA6AEB0),
                                                            fontSize: UiHelper
                                                                    .displayWidth(
                                                                        context) *
                                                                0.04),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.000090,
                                          ),
                                          UiHelper.verticalSpace(
                                              vspace: Spacing.medium),
                                          Row(
                                            children: [
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.large),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Icon(
                                                    Icons
                                                        .calendar_month_rounded,
                                                    size: UiHelper.displayWidth(
                                                            context) *
                                                        0.065,
                                                    color:
                                                        const Color(0xFF0062DE),
                                                  )),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.medium),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Date of Birth',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      letterSpacing: 0.3,
                                                      fontFamily: "KumbhSans",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xFF222222),
                                                      fontSize:
                                                          UiHelper.displayWidth(
                                                                  context) *
                                                              0.043),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xxlarge),
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xlarge),
                                                  UiHelper.horizontaSpace(
                                                      hspace: Spacing.xsmall),
                                                  Align(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      width: width * 0.65,
                                                      height: height * 0.03,
                                                      child: Text(
                                                        (dobing).split(' ')[0],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            letterSpacing: 0.1,
                                                            fontFamily:
                                                                "SignikaNegative-Bold",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: const Color(
                                                                0xFFA6AEB0),
                                                            fontSize: UiHelper
                                                                    .displayWidth(
                                                                        context) *
                                                                0.04),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))),
                    )
                  ])));
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = const Color(0xFF0062DE);
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.55);
    path.quadraticBezierTo(
        size.width / 2, size.height / 1.825, size.width, size.height * 0.55);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
