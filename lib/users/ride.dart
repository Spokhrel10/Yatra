// ignore_for_file: unnecessary_new

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import 'package:sajilo_yatra/users/ridesearch.dart';

class Ride extends StatefulWidget {
  final String? going;
  final String? leaving;
  final String? city;
  final int initialIndex;
  const Ride(
      {Key? key, this.going, this.leaving, this.city, this.initialIndex = 0})
      : super(key: key);

  @override
  State<Ride> createState() => _RideState();
}

class _RideState extends State<Ride> {
  @override
  var vehicle = ['Bus', 'Jeep', 'MicroBus', 'Taxi', 'Others'];
  var vehicle1 = [];
  DateTime? dob;
  TextEditingController dobController = TextEditingController();
  DateTime? dob2;
  TextEditingController dobController2 = TextEditingController();
  TextEditingController dobController3 = TextEditingController();
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
                Get.toNamed('/hun1');
              },
            );
          },
        ),
        backgroundColor: const Color(0xFF0062DE),
        title: Text('Ride',
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
              const Text(
                "Search for Available Vehicles",
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 3.5,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF222222),
                    fontSize: 19),
              ),
              Container(
                height: 49.h,
                width: 85.w,
                margin: const EdgeInsets.only(top: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, 0),
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                    ), //BoxShadow
                    //BoxShadow
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 18),
                      width: 270,
                      child: TextFormField(
                        controller: _cityController,
                        readOnly: true,
                        maxLines: 1,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          prefixIcon: Icon(
                            Icons.near_me_rounded,
                            color: Color(0xFF222222),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 242, 243, 245),
                                width: 3,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 242, 243, 245),
                                width: 2,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          labelText: 'Enter City',
                          labelStyle: TextStyle(
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF222222),
                              fontSize: 17.7),
                          suffixIconColor: Color.fromARGB(255, 255, 0, 0),
                        ),
                        style: const TextStyle(
                            fontSize: 18,
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Leaving Destination field cannot be empty';
                          }
                          return '';
                        },
                        onTap: () {
                          Navigator.pushNamed(context, '/line5');
                        },
                      ),
                    ),
                    Container(
                      width: 270,
                      margin: const EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        border: Border.all(
                            color: const Color.fromARGB(255, 242, 243, 245),
                            width: 3,
                            style: BorderStyle.solid),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: DropdownButton2(
                        dropdownMaxHeight: 150,
                        itemSplashColor: const Color(0xFF9BC2F2),
                        itemPadding: const EdgeInsets.only(left: 16),
                        itemHighlightColor: const Color(0xFF9BC2F2),
                        isExpanded: true,
                        iconSize: 42,
                        buttonPadding: const EdgeInsets.only(top: 5, bottom: 5),
                        iconEnabledColor: const Color(0xFF222222),
                        iconDisabledColor: const Color(0xFF222222),
                        style: const TextStyle(
                            height: 1,
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF222222),
                            fontSize: 16.7),
                        underline: Container(color: Colors.transparent),
                        hint: const Text(
                          "Choose Vehicle",
                          style: TextStyle(
                              fontSize: 16.7, color: Color(0xFF222222)),
                        ),
                        value: drop,
                        items: vehicle.map((itemone) {
                          return DropdownMenuItem(
                              value: itemone, child: Text(itemone));
                        }).toList(),
                        onChanged: (String? newvalue) {
                          setState(() {
                            drop = newvalue!;
                            print(drop);
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 270,
                      margin: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: dobController,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              suffixIcon: Icon(
                                Icons.calendar_month_rounded,
                                size: 28,
                                color: Color(0xFF222222),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 242, 243, 245),
                                    width: 3,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 242, 243, 245),
                                    width: 2,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              labelText: 'Pickup',
                              hintText: 'Pickup',
                              hintStyle: TextStyle(
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF222222),
                                  fontSize: 16.7),
                              labelStyle: TextStyle(
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF222222),
                                  fontSize: 17.7),
                              suffixIconColor: Color.fromARGB(255, 255, 0, 0),
                            ),
                            style: const TextStyle(
                                fontSize: 18,
                                fontFamily: "Mulish",
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 0, 0, 0)),
                            onTap: () async {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              final DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (date != null) {
                                dobController.text =
                                    DateFormat("yyyy-MM-dd").format(date);
                                dob = date;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 270,
                      margin: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: dobController2,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              suffixIcon: Icon(
                                Icons.calendar_month_rounded,
                                size: 28,
                                color: Color(0xFF222222),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 242, 243, 245),
                                    width: 3,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 242, 243, 245),
                                    width: 2,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              labelText: 'Hire till',
                              hintText: 'Hire till',
                              hintStyle: TextStyle(
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF222222),
                                  fontSize: 16.7),
                              labelStyle: TextStyle(
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF222222),
                                  fontSize: 17.7),
                              suffixIconColor: Color.fromARGB(255, 255, 0, 0),
                            ),
                            style: const TextStyle(
                                fontSize: 18,
                                fontFamily: "Mulish",
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 0, 0, 0)),
                            onTap: () async {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              final DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (date != null) {
                                dobController2.text =
                                    DateFormat("yyyy-MM-dd").format(date);
                                dob2 = date;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                heightFactor: 0.75,
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 40.4,
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF222222),

                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(
                              6)), //background color of button
                    ),
                    child: const Text(
                      "Search",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.2,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFFFFFFF),
                          fontSize: 16),
                    ),
                    onPressed: () {
                      print(drop);
                      dobController3.text = drop.toString();
                      if (dobController.text.isNotEmpty && drop != null) {
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OutSearchScreen(
                                      leaving: _cityController.text,
                                      going: _goingController.text,
                                      type: dobController3.text,
                                      dob: dobController.text)));
                        }
                      } else {
                        Get.snackbar(
                          "Error",
                          "Please fill out all the fields",
                          backgroundColor: Colors.red.shade400,
                          colorText: Colors.grey.shade900,
                          duration: const Duration(milliseconds: 3000),
                          snackPosition: SnackPosition.TOP,
                          margin: const EdgeInsets.all(10),
                          borderRadius: 10,
                          borderWidth: 2,
                          borderColor: Colors.red,
                          animationDuration: const Duration(milliseconds: 400),
                        );
                      }
                    },
                  ),
                ),
              ),
              Container(
                height: 3.h,
              )
            ],
          )),
        ),
      ),
    );
  }
}
