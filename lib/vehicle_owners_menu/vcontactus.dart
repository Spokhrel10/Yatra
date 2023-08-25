// ignore_for_file: unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/controllers/bottom_nav_controller.dart';

class VContact extends StatefulWidget {
  const VContact({
    Key? key,
  }) : super(key: key);

  @override
  State<VContact> createState() => _VContactState();
}

class _VContactState extends State<VContact> {
  @override
  DateTime? dob;
  TextEditingController dobController = TextEditingController();
  DateTime? dob2;
  TextEditingController dobController2 = TextEditingController();
  String? drop;

  TextEditingController nameController = TextEditingController();
  String? fullname;
  TextEditingController emailController = TextEditingController();
  String? email;
  TextEditingController messageController = TextEditingController();
  String? message;
  final _formKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          backgroundColor: const Color(0xFF0062DE),
          title: Text('Contact Us',
              style: TextStyle(
                letterSpacing: 0.95,
                color: const Color(0xFFFFFFFF),
                fontFamily: 'ComicNeue',
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
              )),
        ),
        body: Container(
          color: const Color(0xFFFFFFFF),
          child: Form(
            key: _formKey,
            child: Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 1,
                    child: Image.asset(
                      "images/cover.png",
                      width: 480,
                      height: 160,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    height: 0.5.h,
                  ),
                  Text("FEEL FREE TO DROP US A MESSAGE!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceSansPro(
                          height: 0.35.h,
                          letterSpacing: 2.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4E93E8),
                          fontSize: 18.sp)),
                  Container(
                    height: 2.95.h,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 15.w,
                      ),
                      Icon(
                        Icons.person,
                        size: 22.sp,
                        color: const Color(0xFF0062DE),
                      ),
                      Container(
                        width: 2.w,
                      ),
                      Text('NAME',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.heebo(
                              letterSpacing: 1.4.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF4E93E8),
                              fontSize: 16.sp)),
                    ],
                  ),
                  Container(
                    height: 1.75.h,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: TextFormField(
                      controller: nameController,
                      maxLines: 1,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF4E93E8),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF4E93E8),
                              width: 1.w,
                              style: BorderStyle.solid),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF4E93E8),
                              width: 1.w,
                              style: BorderStyle.solid),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        hintText: 'Enter Your Name',
                        hintStyle: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFFFFFF),
                            fontSize: 16.8.sp),
                        suffixIconColor: const Color.fromARGB(255, 255, 0, 0),
                      ),
                      style: TextStyle(
                          fontSize: 16.8.sp,
                          fontFamily: "Mulish",
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name field cannot be empty';
                        }

                        final nameRegExp =
                            RegExp(r'^[A-Za-z]+(?:\s[A-Za-z]+)*$');
                        if (!nameRegExp.hasMatch(value)) {
                          return 'Please enter a valid name';
                        }

                        return null;
                      },
                      onChanged: (String val) {
                        fullname = val;
                      },
                    ),
                  ),
                  Container(
                    height: 1.75.h,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 15.w,
                      ),
                      Icon(
                        Icons.mail_rounded,
                        size: 22.sp,
                        color: const Color(0xFF0062DE),
                      ),
                      Container(
                        width: 2.w,
                      ),
                      Text('EMAIL',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.heebo(
                              letterSpacing: 1.4.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF4E93E8),
                              fontSize: 16.sp)),
                    ],
                  ),
                  Container(
                    height: 1.75.h,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: TextFormField(
                      controller: emailController,
                      maxLines: 1,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF4E93E8),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF4E93E8),
                              width: 1.w,
                              style: BorderStyle.solid),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF4E93E8),
                              width: 1.w,
                              style: BorderStyle.solid),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        hintText: 'Enter Your Email',
                        hintStyle: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFFFFFF),
                            fontSize: 16.8.sp),
                        suffixIconColor: const Color.fromARGB(255, 255, 0, 0),
                      ),
                      style: TextStyle(
                          fontSize: 16.8.sp,
                          fontFamily: "Mulish",
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email field cannot be empty';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onChanged: (String val) {
                        email = val;
                      },
                    ),
                  ),
                  Container(
                    height: 1.75.h,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 15.w,
                      ),
                      Icon(
                        Icons.message,
                        size: 22.sp,
                        color: const Color(0xFF0062DE),
                      ),
                      Container(
                        width: 2.w,
                      ),
                      Text('MESSAGE',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.heebo(
                              letterSpacing: 1.4.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF4E93E8),
                              fontSize: 16.sp)),
                    ],
                  ),
                  Container(
                    height: 1.75.h,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: TextFormField(
                      controller: messageController,
                      maxLines: 4,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF4E93E8),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF4E93E8),
                              width: 1.w,
                              style: BorderStyle.solid),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF4E93E8),
                              width: 1.w,
                              style: BorderStyle.solid),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        hintText: 'Enter Your Message',
                        hintStyle: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFFFFFF),
                            fontSize: 16.8.sp),
                        suffixIconColor: const Color.fromARGB(255, 255, 0, 0),
                      ),
                      style: TextStyle(
                          fontSize: 16.8.sp,
                          fontFamily: "Mulish",
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Message field cannot be empty';
                        }
                        return null;
                      },
                      onChanged: (String val) {
                        message = val;
                      },
                    ),
                  ),
                  Container(
                    height: 4.h,
                  ),
                  SizedBox(
                    height: 8.h,
                    width: 80.w,
                    child: GetBuilder<BottomNavController>(builder: (data) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                              0xFF0062DE), //background color of button
                          //border width and color

                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text("SEND",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.varelaRound(
                              letterSpacing: 6.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18.sp,
                            )),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              nameController.text.isNotEmpty &&
                              emailController.text.isNotEmpty &&
                              messageController.text.isNotEmpty) {
                            db.collection('vehicle_contact').add({
                              'full_name': nameController.text,
                              'email': emailController.text,
                              'message': messageController.text,
                            });

                            // show success message and navigate to the next screen
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text:
                                  'Your message has been submitted successfully!',
                              confirmBtnColor: const Color(0xFF0062DE),
                              onConfirmBtnTap: () {
                                Get.back();
                              },
                            );
                          }
                        },
                      );
                    }),
                  ),
                  Container(
                    height: 3.4.h,
                  ),
                ],
              )),
            ),
          ),
        ));
  }
}
