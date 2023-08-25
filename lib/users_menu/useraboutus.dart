// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UAboutUs extends StatefulWidget {
  final String? going;
  final String? leaving;
  final String? city;
  final int initialIndex;
  const UAboutUs(
      {Key? key, this.going, this.leaving, this.city, this.initialIndex = 0})
      : super(key: key);

  @override
  State<UAboutUs> createState() => _UAboutUsState();
}

class _UAboutUsState extends State<UAboutUs> {
  @override
  var vehicle = ['Bus', 'Jeep', 'MicroBus', 'Taxi', 'Others'];
  var vehicle1 = [];
  DateTime? dob;
  TextEditingController dobController = TextEditingController();
  DateTime? dob2;
  TextEditingController dobController2 = TextEditingController();
  String? drop;
  late TextEditingController _goingController;
  late TextEditingController _leavingController;
  late TextEditingController _cityController;

  @override
  void initState() {
    super.initState();
    _goingController = TextEditingController(text: widget.going);
    _leavingController = TextEditingController(text: widget.leaving);
    _cityController = TextEditingController(text: widget.city);
  }

  @override
  void dispose() {
    _goingController.dispose();
    _leavingController.dispose();
    _cityController.dispose();
    super.dispose();
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
                Get.back();
              },
            );
          },
        ),
        backgroundColor: const Color(0xFF0062DE),
        title: Text('About Us',
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
              Text(
                "OUR MISSION",
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 0.35.h,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF222222),
                    fontSize: 19),
              ),
              Container(
                height: 1.2.h,
              ),
              Text(
                "The mission of Sajilo Yatra is to simplify and \nenhance the travel experience for individuals \nby providing a user-friendly platform for \nbooking bus and train tickets. Our aim is \nto make travel planning easy and \naccessible for everyone, offering a seamless \nsolution where users can effortlessly search, \ncompare, and book tickets from a wide range \nof travel companies across North America and \nEurope. \n\nWe prioritize user satisfaction and strive to \ndeliver a high-quality service that saves time, \nreduces hassle, and ensures a pleasant \njourney. Transparency, reliability, and security \nare important to us, and we work closely with \nour travel partners to provide accurate \ninformation, reliable services, and secure \ntransactions. \n\nWe embrace innovation and continuously \nimprove our services by leveraging \ntechnological advancements and \ndata-driven insights. Through regular \nupdates and enhancements, we aim to stay \nahead of customer needs and provide an \nexceptional user experience. \n\nOur goal is to revolutionize the way people \nplan and book their bus and train travel, \nmaking it simpler, more convenient, and \nenjoyable. We are dedicated to delivering \nexcellence and becoming the preferred \nplatform for hassle-free travel booking.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    height: 0.4.h,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF222222),
                    fontSize: 16.sp),
              ),
              Container(
                height: 1.95.h,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
