import 'dart:math';
import 'package:sendgrid_mailer/sendgrid_mailer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:sajilo_yatra/helpers/ui_helper.dart';

class VehicleHome extends StatefulWidget {
  final String userId;
  final String going;
  final String leaving;
  final String location;

  const VehicleHome({
    Key? key,
    required this.userId,
    required this.going,
    required this.leaving,
    required this.location,
  }) : super(key: key);

  @override
  State<VehicleHome> createState() => _VehicleHomeState();
}

class _VehicleHomeState extends State<VehicleHome> {
  final _storage = const FlutterSecureStorage();
  var vehicle = ['Bus', 'Jeep', 'MicroBus', 'Taxi', 'Others'];
  var vehicle1 = [];
  final _formKey = GlobalKey<FormState>();
  DateTime? dob;
  String referenceId = "";
  final TimeOfDay _time = TimeOfDay.now();
  TextEditingController dobController = TextEditingController();
  DateTime? dob2;
  TextEditingController dobController2 = TextEditingController();
  TextEditingController dobController3 = TextEditingController();
  String? drop;
  TextEditingController _goingController = TextEditingController();
  TextEditingController _leavingController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _timeController2 = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController vehController = TextEditingController();
  String discount = "";
  String d2 = "";

  var isLoading = false;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final db = FirebaseFirestore.instance;
  String username = "";
  String vehiclenam = "";
  String seats = "";
  String departure = "";
  String arrival = "";
  String depart = "";
  String arrive = "";
  String ddob = "";
  String rdob = "";
  String price = "";
  String veh = "";
  String date1 = "";
  String date2 = "";
  String arrive1 = "";
  String date3 = "";
  String date4 = "";
  String arrive2 = "";

  @override
  void initState() {
    super.initState();
    _goingController = TextEditingController(text: widget.going);
    _leavingController = TextEditingController(text: widget.leaving);
    dobController2 = TextEditingController(text: widget.location);
    _savedData1();
    _getSavedData();
    _savedData2();
  }

  @override
  void dispose() {
    _timeController.dispose();
    _timeController2.dispose();
    _goingController.dispose();
    _leavingController.dispose();
    dobController2.dispose();
    super.dispose();
  }

  void _getSavedData() async {
    final fullName = await _storage.read(key: 'full_name');
    final vehicleName = await _storage.read(key: 'vehicle_name');
    final seat = await _storage.read(key: 'vehicle_seats');
    setState(() {
      username = fullName!;
      veh = fullName;
      vehiclenam = vehicleName!;
      seats = seat!;
    });
  }

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  String generateBookingId() {
    var rng = Random();
    var codeUnits = List.generate(10, (index) {
      return rng.nextInt(26) +
          65; // generates a code unit between 65 and 90 (inclusive) for A-Z characters
    });

    return String.fromCharCodes(codeUnits);
  }

  Future<void> _selectTime2(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        _timeController2.text = pickedTime.format(context);
      });
    }
  }

  final currentDate = DateTime.now();
  final currentTime = TimeOfDay.now();

  Future<void> _savedData1() async {
    final vehName = await _storage.read(key: 'vehicle_name');
    print(vehName);

    final snapshot = await db
        .collection("vehicle_home")
        .where('Vehicle', isEqualTo: vehName)
        .get();

    final vehicleOwners = snapshot.docs.map((doc) => doc.data()).toList();

    if (vehicleOwners.isNotEmpty) {
      // check if there is at least one document in the snapshot
      final data = vehicleOwners.last;

      final arrive = data['Arrive'];
      final ddate = data['D_date'];
      final rdate = data['R_date'];

      await _storage.write(key: 'Arrive', value: arrive);
      await _storage.write(key: 'D_date', value: ddate);
      await _storage.write(key: 'R_date', value: rdate);

      setState(() {
        arrive1 = arrive;
        date1 = ddate;
        date2 = rdate;
        isLoading = false;
      });
    } else {
      print('No documents found for the user');
    }
  }

  Future<void> _savedData2() async {
    final vehName = await _storage.read(key: 'vehicle_name');
    print(vehName);

    final snapshot = await db
        .collection("vehicle_rental")
        .where('Vehicle', isEqualTo: vehName)
        .get();

    final vehicleOwners = snapshot.docs.map((doc) => doc.data()).toList();

    if (vehicleOwners.isNotEmpty) {
      // check if there is at least one document in the snapshot
      final data = vehicleOwners.last;

      final arrive = data['Arrive'];
      final ddate = data['D_date'];
      final rdate = data['R_date'];

      await _storage.write(key: 'Arrive', value: arrive);
      await _storage.write(key: 'D_date', value: ddate);
      await _storage.write(key: 'R_date', value: rdate);

      setState(() {
        arrive2 = arrive;
        date3 = ddate;
        date4 = rdate;
        isLoading = false;
      });
    } else {
      print('No documents found for the user');
    }
  }

  register() async {
    final vehicleName = await _storage.read(key: 'vehicle_name');
    final seat = await _storage.read(key: 'vehicle_seats');
    discount = priceController.text * int.parse(seat!).round();
    DateTime parsedDate = DateTime.tryParse(date2) ?? DateTime(2023, 5, 21);
    DateTime parsedDate1 = DateTime.tryParse(date4) ?? DateTime(2023, 5, 24);

    print(parsedDate);
    print(currentDate);
    print(parsedDate1);

    print(seat);
    QuickAlert.show(
      context: context,
      onConfirmBtnTap: () {
        if (dobController.text.isEmpty ||
            dobController2.text.isEmpty ||
            dobController3.text.isEmpty ||
            _timeController.text.isEmpty ||
            _timeController2.text.isEmpty ||
            _leavingController.text.isEmpty ||
            _goingController.text.isEmpty ||
            priceController.text.isEmpty ||
            vehicleName!.isEmpty) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'Please fill up all the fields',
            confirmBtnColor: const Color(0xFF0062DE),
            onConfirmBtnTap: () {
              Get.to('/third2');
            },
          );
        } else if ((int.tryParse(priceController.text) == null) ||
            (int.tryParse(priceController.text)! <= 1) ||
            (int.tryParse(priceController.text)! >= 999)) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'Seat Price must be between 1 and 999',
            confirmBtnColor: const Color(0xFF0062DE),
          );
        } else if (parsedDate.isAfter(DateTime.now())) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'You can only publish after your return date have expired.',
            confirmBtnColor: const Color(0xFF0062DE),
          );
        } else {
          final bookingId = generateBookingId();
          db.collection('vehicle_home').add({
            'Vehicle': vehicleName,
            'Arrival': _goingController.text,
            'Arrive': _timeController2.text,
            'D_date': dobController.text,
            'Depart': _timeController.text,
            'Departure': _leavingController.text,
            'Price': priceController.text,
            'Meet': dobController2.text,
            'R_Date': dobController3.text,
            'Booking': bookingId
          });

          Get.snackbar(
            "Publication Successful",
            "Vehicle Availability published!",
            backgroundColor: const Color(0xFF85bb65),
            colorText: Colors.grey.shade900,
            duration: const Duration(milliseconds: 3000),
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(10),
            borderRadius: 10,
            borderWidth: 2,
            borderColor: const Color(0xFF85bb65),
            animationDuration: const Duration(milliseconds: 400),
          );
          sendMail(bookingId);
          Get.toNamed('/third2', arguments: [
            {'index': 2},
          ])!
              .then((result) {
            if (result[0]["backValue"] == "one") {
              print("Result is coming");
            }
          });
        }
      },
      type: QuickAlertType.confirm,
      text: 'You want to publish tickets',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      onCancelBtnTap: () {
        QuickAlert.show(
          context: context,
          onConfirmBtnTap: () {
            if (dobController.text.isEmpty ||
                dobController2.text.isEmpty ||
                dobController3.text.isEmpty ||
                _timeController.text.isEmpty ||
                _timeController2.text.isEmpty ||
                _leavingController.text.isEmpty ||
                _goingController.text.isEmpty ||
                priceController.text.isEmpty ||
                vehicleName!.isEmpty) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: 'Please fill up all the fields',
                confirmBtnColor: const Color(0xFF0062DE),
                onConfirmBtnTap: () {
                  Get.toNamed('/third2');
                },
              );
            } else if ((int.tryParse(priceController.text) == null) ||
                (int.tryParse(priceController.text)! <= 1) ||
                (int.tryParse(priceController.text)! >= 999)) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: 'Seat Price must be between 1 and 999',
                confirmBtnColor: const Color(0xFF0062DE),
              );
            } else if (parsedDate.isAfter(DateTime.now())) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text:
                    'You can only publish after your return date have expired.',
                confirmBtnColor: const Color(0xFF0062DE),
              );
            } else {
              final bookingId = generateBookingId();
              db.collection('vehicle_rental').add({
                'Vehicle': vehicleName,
                'Arrival': _goingController.text,
                'Arrive': _timeController2.text,
                'D_date': dobController.text,
                'Depart': _timeController.text,
                'Departure': _leavingController.text,
                'Price': priceController.text,
                'Meet': dobController2.text,
                'R_Date': dobController3.text,
                'Booking': bookingId
              });

              Get.snackbar(
                "Publication Successful",
                "Vehicle Availability published!",
                backgroundColor: const Color(0xFF85bb65),
                colorText: Colors.grey.shade900,
                duration: const Duration(milliseconds: 3000),
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.all(10),
                borderRadius: 10,
                borderWidth: 2,
                borderColor: const Color(0xFF85bb65),
                animationDuration: const Duration(milliseconds: 400),
              );
              sendMail1(bookingId);
              Get.toNamed('/third2', arguments: [
                {'index': 2},
              ])!
                  .then((result) {
                if (result[0]["backValue"] == "one") {
                  print("Result is coming");
                }
              });
            }
          },
          type: QuickAlertType.confirm,
          text: 'You want to publish vehicle rentals',
          confirmBtnText: 'Yes',
          cancelBtnText: 'No',
          onCancelBtnTap: () {
            Get.toNamed('/third2');
          },
          confirmBtnColor: const Color(0xFF0062DE),
        );
      },
      confirmBtnColor: const Color(0xFF0062DE),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0062DE),
        title: Container(
          margin: const EdgeInsets.only(bottom: 2),
          child: Text('Welcome ${username.split(' ')[0]}',
              style: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontFamily: 'ComicNeue',
                fontSize: UiHelper.displayWidth(context) * 0.055,
                fontWeight: FontWeight.w900,
              )),
        ),
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 6),
            child: IconButton(
              icon: Icon(
                Icons.account_circle_outlined,
                color: const Color(0xFFFFFFFF),
                size: UiHelper.displayWidth(context) * 0.085,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/line13');
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: isLoading
            ? Container(
                child: LoadingAnimationWidget.hexagonDots(
                  size: UiHelper.displayWidth(context) * 0.08,
                  color: const Color(0xFF0062DE),
                ),
              )
            : Container(
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          child: Column(children: [
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: const Color(0xFFFFFFFF),
                                        width:
                                            UiHelper.displayWidth(context) * 1,
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.07,
                                        child: Text(
                                          vehiclenam,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.00310,
                                            fontFamily: "Cambay",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF0062DE),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
                                                    0.065,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 92.h,
                              width: UiHelper.displayWidth(context) * 0.9,
                              margin: const EdgeInsets.only(top: 18),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(14)),
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
                              child: Column(children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 18),
                                  width: 290,
                                  child: TextFormField(
                                    controller: _leavingController,
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
                                            color: Color.fromARGB(
                                                255, 242, 243, 245),
                                            width: 3,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 242, 243, 245),
                                            width: 2,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      hintText: 'Enter your departure location',
                                      hintStyle: TextStyle(
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF222222),
                                          fontSize: 16.7),
                                      labelText: 'Departure Location',
                                      labelStyle: TextStyle(
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF222222),
                                          fontSize: 17.7),
                                      suffixIconColor:
                                          Color.fromARGB(255, 255, 0, 0),
                                    ),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Mulish",
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Departure Location field cannot be empty';
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      Navigator.pushNamed(context, '/line8');
                                    },
                                    onChanged: (String val) {
                                      departure = val;
                                      print(departure);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 12),
                                  width: 290,
                                  child: TextFormField(
                                    controller: _goingController,
                                    maxLines: 1,
                                    readOnly: true,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
                                      prefixIcon: Icon(
                                        Icons.location_on_rounded,
                                        color: Color(0xFF222222),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 242, 243, 245),
                                            width: 3,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 242, 243, 245),
                                            width: 2,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      hintText: 'Enter your arrival location',
                                      hintStyle: TextStyle(
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF222222),
                                          fontSize: 16.7),
                                      labelText: 'Arrival Location',
                                      labelStyle: TextStyle(
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF222222),
                                          fontSize: 17.7),
                                      suffixIconColor:
                                          Color.fromARGB(255, 255, 0, 0),
                                    ),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Mulish",
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Arrival Location field cannot be empty';
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      Navigator.pushNamed(context, '/line8');
                                    },
                                    onChanged: (String val) {
                                      arrival = val;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 12),
                                  width: 290,
                                  child: TextFormField(
                                    controller: _timeController,
                                    maxLines: 1,
                                    readOnly: true,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
                                      prefixIcon: Icon(
                                        Icons.access_time_filled_rounded,
                                        color: Color(0xFF222222),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 242, 243, 245),
                                            width: 3,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 242, 243, 245),
                                            width: 2,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      labelText: 'Departing Time',
                                      labelStyle: TextStyle(
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF222222),
                                          fontSize: 17.7),
                                      suffixIconColor:
                                          Color.fromARGB(255, 255, 0, 0),
                                    ),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Mulish",
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Departing Time field cannot be empty';
                                      }
                                      return null;
                                    },
                                    onTap: () => _selectTime(context),
                                    onChanged: (String val) {
                                      depart = val;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 12),
                                  width: 290,
                                  child: TextFormField(
                                    controller: _timeController2,
                                    maxLines: 1,
                                    readOnly: true,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
                                      prefixIcon: Icon(
                                        Icons.access_time_filled_rounded,
                                        color: Color(0xFF222222),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 242, 243, 245),
                                            width: 3,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 242, 243, 245),
                                            width: 2,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      labelText: 'Arriving Time',
                                      labelStyle: TextStyle(
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF222222),
                                          fontSize: 17.7),
                                      suffixIconColor:
                                          Color.fromARGB(255, 255, 0, 0),
                                    ),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Mulish",
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Arrival Time field cannot be empty';
                                      }
                                      return null;
                                    },
                                    onTap: () => _selectTime2(context),
                                    onChanged: (String val) {
                                      arrive = val;
                                    },
                                  ),
                                ),
                                Container(
                                  width: 290,
                                  margin: const EdgeInsets.only(top: 12),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: dobController2,
                                        readOnly: true,
                                        decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: Color(0xFFFFFFFF),
                                          prefixIcon: Icon(
                                            Icons.location_on_rounded,
                                            color: Color(0xFF222222),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 242, 243, 245),
                                                width: 3,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 242, 243, 245),
                                                width: 2,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          labelText: 'Meeting Location',
                                          hintText:
                                              'Enter your meeting location',
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
                                          suffixIconColor:
                                              Color.fromARGB(255, 255, 0, 0),
                                        ),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Meeting Location field cannot be empty';
                                          }
                                          return null;
                                        },
                                        onTap: () {
                                          Get.toNamed('/line25');
                                        },
                                        onChanged: (String val) {
                                          rdob = val;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 290,
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
                                                color: Color.fromARGB(
                                                    255, 242, 243, 245),
                                                width: 3,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 242, 243, 245),
                                                width: 2,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          labelText: 'Departing',
                                          hintText: 'Departing',
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
                                          suffixIconColor:
                                              Color.fromARGB(255, 255, 0, 0),
                                        ),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                        onTap: () async {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          final DateTime? date =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2100),
                                          );
                                          if (date != null) {
                                            dobController.text =
                                                DateFormat("yyyy-MM-dd")
                                                    .format(date);
                                            dob = date;
                                          }
                                        },
                                        onChanged: (String val) {
                                          ddob = val;
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select your departing date';
                                          }
                                          // Add any additional validation logic for the date if needed
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 290,
                                  margin: const EdgeInsets.only(top: 12),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: dobController3,
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
                                                color: Color.fromARGB(
                                                    255, 242, 243, 245),
                                                width: 3,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 242, 243, 245),
                                                width: 2,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          labelText: 'Return',
                                          hintText: 'Return',
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
                                          suffixIconColor:
                                              Color.fromARGB(255, 255, 0, 0),
                                        ),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                        onTap: () async {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          final DateTime? date =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2100),
                                          );
                                          if (date != null) {
                                            dobController3.text =
                                                DateFormat("yyyy-MM-dd")
                                                    .format(date);
                                            dob2 = date;
                                          }
                                        },
                                        onChanged: (String val) {
                                          rdob = val;
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select your return date';
                                          }
                                          // Add any additional validation logic for the date if needed
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 12),
                                  width: 290,
                                  child: TextFormField(
                                    controller: priceController,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
                                      prefixIcon: Icon(
                                        Icons.currency_rupee_rounded,
                                        color: Color(0xFF222222),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 242, 243, 245),
                                            width: 3,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 242, 243, 245),
                                            width: 2,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      labelText: 'Seat Price',
                                      hintText: 'Enter Your Seat Price',
                                      labelStyle: TextStyle(
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF222222),
                                          fontSize: 17.7),
                                      hintStyle: TextStyle(
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF222222),
                                          fontSize: 17.7),
                                      suffixIconColor:
                                          Color.fromARGB(255, 255, 0, 0),
                                    ),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Mulish",
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Seat Price field cannot be empty';
                                      }
                                      if (int.tryParse(value) == null) {
                                        return 'Seat Price must be a valid number';
                                      }
                                      final age = int.parse(value);
                                      if (age < 1 || age > 999) {
                                        return 'Seat Price must be between 1 and 999';
                                      }
                                      return null;
                                    },
                                    onChanged: (String val) {
                                      price = val;
                                    },
                                  ),
                                ),
                              ]),
                            ),
                            Align(
                              heightFactor: 0.65,
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                height: 40.4,
                                width: 140,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF222222),

                                      shape: RoundedRectangleBorder(
                                          //to set border radius to button
                                          borderRadius: BorderRadius.circular(
                                              6)), //background color of button
                                    ),
                                    child: const Text(
                                      "Publish",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: 1.2,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 16),
                                    ),
                                    onPressed: () {
                                      register();
                                    }),
                              ),
                            ),
                            Container(height: 4.h),
                          ]),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
      ),
    );
  }

  void sendMail(String bookingId) async {
    final emailing = await _storage.read(key: 'email');
    print(emailing);

    final mailer = Mailer(
        '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');
    const toAddress = Address('dipeshgurung797@gmail.com');
    const fromAddress = Address('dgisfit@gmail.com');
    final content = Content('text/plain',
        'Hello,\n\nYour ticket id ($bookingId) has been confirmed.');
    final subject = 'Ticket Published - $bookingId';
    const personalization = Personalization([toAddress]);

    final email =
        Email([personalization], fromAddress, subject, content: [content]);
    mailer.send(email).then((result) {
      print(result.isValue);
    });
  }

  void sendMail1(String bookingId) async {
    final emailing = await _storage.read(key: 'email');
    print(emailing);

    final mailer = Mailer(
        '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');
    const toAddress = Address('dipeshgurung797@gmail.com');
    const fromAddress = Address('dgisfit@gmail.com');
    final content = Content('text/plain',
        'Hello,\n\nYour rental id ($bookingId) has been confirmed.');
    final subject = 'Vehicle Rental Published - $bookingId';
    const personalization = Personalization([toAddress]);

    final email =
        Email([personalization], fromAddress, subject, content: [content]);
    mailer.send(email).then((result) {
      print(result.isValue);
    });
  }
}
