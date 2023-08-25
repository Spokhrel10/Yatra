import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/helpers/ui_helper.dart';

import '../controllers/bottom_nav_controller.dart';

class FeedbacksScreen extends StatefulWidget {
  const FeedbacksScreen({Key? key}) : super(key: key);

  @override
  State<FeedbacksScreen> createState() => _FeedbacksScreenState();
}

class _FeedbacksScreenState extends State<FeedbacksScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _newPasswordController = TextEditingController();

  final bool _isLoading = false;
  final bool _isObscured = true;
  final db = FirebaseFirestore.instance;
  String referenceId = "";

  final List<Map<String, dynamic>> _dataList = [];

  final _phoneController = TextEditingController();
  final _seatController = TextEditingController();
  final _discountController = TextEditingController();

  TextEditingController dobController = TextEditingController();
  TextEditingController dobController2 = TextEditingController();
  String? username;
  String? locat;
  String? emailing;
  String? phonenumber;
  String? gen;
  String? aging;
  String? dobing;
  String? date;
  String? vehiclename;
  String? vehiclefacility;
  String? arrive;
  String? depart;
  String? seats;
  int? seats1;
  int totalSeats = 0;
  String? sprice;

  Map<String, int> discountPrices = {
    "YGFJY899": 50,
    "UIGF78": 10,
    "HRDTY56": 15,
    "AKI745": 20,
    "HGHG7": 25,
    "JHVJ34": 30,
  };

  var isLoading = true;
  @override
  void initState() {
    super.initState();

    isLoading = false;
  }

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
                Navigator.pop(context);
              },
            );
          },
        ),
        backgroundColor: const Color(0xFF0062DE),
        title: Text('Feedback',
            style: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontFamily: 'ComicNeue',
              fontSize: UiHelper.displayWidth(context) * 0.055,
              fontWeight: FontWeight.w900,
            )),
      ),
      body: isLoading
          ? Center(
              child: Container(
              child: LoadingAnimationWidget.hexagonDots(
                size: UiHelper.displayWidth(context) * 0.08,
                color: const Color(0xFF0062DE),
              ),
            ))
          : Container(
              color: const Color(0xFFFFFFFF),
              child: Form(
                key: _formKey,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
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
                          height: 2.75.h,
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
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: SizedBox(
                            child: TextFormField(
                              controller: _nameController,
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
                                suffixIconColor:
                                    const Color.fromARGB(255, 255, 0, 0),
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
                                username = val;
                              },
                            ),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: SizedBox(
                            width: 80.w,
                            child: TextFormField(
                              controller: _emailController,
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
                                suffixIconColor:
                                    const Color.fromARGB(255, 255, 0, 0),
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
                                emailing = val;
                              },
                            ),
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
                              Icons.phone,
                              size: 22.sp,
                              color: const Color(0xFF0062DE),
                            ),
                            Container(
                              width: 2.w,
                            ),
                            Text('PHONE NUMBER',
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
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: SizedBox(
                            width: 80.w,
                            child: TextFormField(
                              controller: _phoneController,
                              maxLines: 1,
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.number,
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
                                hintText: 'Enter Your Phone Number',
                                hintStyle: TextStyle(
                                    fontFamily: "Mulish",
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: 16.8.sp),
                                suffixIconColor:
                                    const Color.fromARGB(255, 255, 0, 0),
                              ),
                              style: TextStyle(
                                  fontSize: 16.8.sp,
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Phone Number field cannot be empty';
                                } else if (!RegExp(r'^[0-9]{10}$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid 10-digit phone number';
                                }
                                return null;
                              },
                              onChanged: (String val) {
                                phonenumber = val;
                              },
                            ),
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
                              Icons.person,
                              size: 22.sp,
                              color: const Color(0xFF0062DE),
                            ),
                            Container(
                              width: 2.w,
                            ),
                            Text('FEEDBACK',
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
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: SizedBox(
                            width: 80.w,
                            child: TextFormField(
                              controller: _discountController,
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
                                hintText: 'Enter Your Feedback',
                                hintStyle: TextStyle(
                                    fontFamily: "Mulish",
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: 16.8.sp),
                                suffixIconColor:
                                    const Color.fromARGB(255, 255, 0, 0),
                              ),
                              style: TextStyle(
                                  fontSize: 16.8.sp,
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Feedback field cannot be empty';
                                }
                                final feedbackRegExp =
                                    RegExp(r'^[a-zA-Z0-9.,!?"\s]+$');
                                if (!feedbackRegExp.hasMatch(value)) {
                                  return 'Please enter a valid feedback';
                                }
                                return null;
                              },
                              onChanged: (String val) {
                                username = val;
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: 4.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: SizedBox(
                            height: 8.h,
                            width: 80.w,
                            child: GetBuilder<BottomNavController>(
                                builder: (data) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                      0xFF0062DE), //background color of button
                                  //border width and color

                                  shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Text("SUBMIT",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.varelaRound(
                                      letterSpacing: 6.5.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fontSize: 18.sp,
                                    )),
                                onPressed: () {
                                  if (_formKey.currentState!.validate() &&
                                      _nameController.text.isNotEmpty &&
                                      _emailController.text.isNotEmpty &&
                                      _phoneController.text.isNotEmpty &&
                                      _discountController.text.isNotEmpty) {
                                    db.collection('users_feedbacks').add({
                                      'Feedback': _discountController.text,
                                      'Email': _emailController.text,
                                      'Full_Name': _nameController.text,
                                      'Mobile_Number': _phoneController.text,
                                    });

                                    // show success message and navigate to the next screen
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      text: 'Feedback Submitted Successfully!',
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
                        ),
                        Container(
                          height: 3.4.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
