// ignore_for_file: unnecessary_new

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/helpers/ui_helper.dart';

class VEdit extends StatefulWidget {
  final String userId;
  const VEdit({Key? key, required this.userId}) : super(key: key);

  @override
  State<VEdit> createState() => _VEditState();
}

class _VEditState extends State<VEdit> {
  var items = ['Male', 'Female', 'Others'];
  var item1 = [];
  var vehicle = ['Bus', 'Jeep', 'MicroBus', 'Taxi', 'Others'];
  var vehicle1 = [];
  var vehicle2 = [
    'None',
    'Air Conditioning',
    'Air Conditioning & Wi-Fi',
    'Wi-Fi',
    'TV & Bluetooth',
    'Bluetooth',
    'TV',
    'Luggage Storage',
    'Wi-Fi & Power Outlets',
    'Power Outlets',
    'All Basic Facilities'
  ];
  String drop = 'Bus';
  String? pin = 'None';

  DateTime? dob;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _vehnameController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _genController = TextEditingController();
  final _ageController = TextEditingController();
  final _dobController = TextEditingController();
  final _typeController = TextEditingController();
  final _facController = TextEditingController();
  final _seatController = TextEditingController();
  final _numController = TextEditingController();
  String dropdownvalue = "Male";

  final bool _isLoading = false;
  final bool _isObscured = true;
  final _storage = const FlutterSecureStorage();
  var isLoading = true;
  String? username;
  String? locat;
  String? emailing;
  String? phonenumber;
  String? gen;
  String? aging;
  String? dobing;

  @override
  void initState() {
    super.initState();

    _getSavedData();
  }

  void _getSavedData() async {
    final fullName = await _storage.read(key: 'full_name');
    final location = await _storage.read(key: 'location');
    final email = await _storage.read(key: 'email');
    final phoneNumber = await _storage.read(key: 'phone_number');
    final gender = await _storage.read(key: 'gender');
    final age = await _storage.read(key: 'age');
    final dob = await _storage.read(key: 'dob');
    setState(() {
      username = fullName;
      locat = location;
      emailing = email;
      phonenumber = phoneNumber;
      gen = gender;
      aging = age;
      dobing = dob;
      isLoading = false;
    });
  }

  var size, height, width;
  var circular = true;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  String creditBalance = "0.00";

  void _resetPassword() async {
    final fullname = _nameController.text.trim();
    final address = _locationController.text.trim();
    final mobile = _phoneController.text.trim();
    final age = _ageController.text.trim();
    final gender = _genController.text.trim();
    final dob = _dobController.text.trim();
    final vehname = _vehnameController.text.trim();
    final type = _typeController.text.trim();
    final vehnum = _numController.text.trim();
    final fac = _facController.text.trim();
    final seats = _seatController.text.trim();
    final dob1 = _dobController.text.trim();

    print(fullname);
    print(address);
    print(mobile);
    print(age);
    print(gender);
    print(dob);
    print(emailing);

    if (fullname.isNotEmpty &&
        address.isNotEmpty &&
        mobile.isNotEmpty &&
        age.isNotEmpty &&
        dob.isNotEmpty &&
        gender.isNotEmpty &&
        vehname.isNotEmpty &&
        type.isNotEmpty &&
        vehnum.isNotEmpty &&
        fac.isNotEmpty &&
        seats.isNotEmpty &&
        dob1.isNotEmpty) {
      final userDocs = await FirebaseFirestore.instance
          .collection("vehicle_owners")
          .where("email", isEqualTo: emailing)
          .get();

      if (userDocs.docs.isNotEmpty) {
        final userDoc = userDocs.docs.first;
        try {
          await userDoc.reference.update({
            "full_name": fullname,
            "location": address,
            "phone": mobile,
            "age": age,
            "gender": gender,
            "dob": dob,
            "vehicle_name": vehname,
            "vehicle_type": type,
            "vehicle_facility": fac,
            "vehicle_number": vehnum,
            "vehicle_seats": seats,
          });
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: "User information updated successfully",
            confirmBtnColor: const Color(0xFF0062DE),
            onConfirmBtnTap: () {
              Get.to('/line13');
            },
          );

          print("User information updated successfully in Firestore");
        } catch (e) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'Error updating user information in Firestore',
            confirmBtnColor: const Color(0xFF0062DE),
          );

          print("Error updating user information in Firestore: $e");
        }
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'No user found in Firestore',
          confirmBtnColor: const Color(0xFF0062DE),
        );

        print("No user found in Firestore");
      }
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Please fill out all fields',
        confirmBtnColor: const Color(0xFF0062DE),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0062DE),
        centerTitle: true,
        title: Text('Edit Profile',
            style: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontFamily: 'ComicNeue',
              fontSize: 19.5.sp,
              fontWeight: FontWeight.w900,
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
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: isLoading
            ? Container(
                child: LoadingAnimationWidget.hexagonDots(
                  size: UiHelper.displayWidth(context) * 0.08,
                  color: const Color(0xFF0062DE),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: TextFormField(
                                        controller: _nameController,
                                        maxLines: 1,
                                        cursorColor: Colors.black,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.edit,
                                            size: UiHelper.displayHeight(
                                                    context) *
                                                0.028,
                                            color: const Color(0xFF222222),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFA6AEB0),
                                                width: 2,
                                                style: BorderStyle.solid),
                                          ),
                                          labelText: 'Full Name',
                                          hintText: 'Enter Your Full Name',
                                          hintStyle: TextStyle(
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.002,
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFA6AEB0),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
                                                    0.043,
                                          ),
                                          labelStyle: TextStyle(
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF222222),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
                                                    0.045,
                                          ),
                                          suffixIconColor: const Color.fromARGB(
                                              255, 255, 0, 0),
                                        ),
                                        style: TextStyle(
                                          fontSize:
                                              UiHelper.displayWidth(context) *
                                                  0.045,
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFA6AEB0),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Full Name field cannot be empty';
                                          }

                                          final nameRegExp = RegExp(
                                              r'^[A-Za-z]+(?:\s[A-Za-z]+)*$');
                                          if (!nameRegExp.hasMatch(value)) {
                                            return 'Please enter a valid name';
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: TextFormField(
                                        controller: _locationController,
                                        maxLines: 1,
                                        cursorColor: Colors.black,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.location_on_rounded,
                                            size: UiHelper.displayHeight(
                                                    context) *
                                                0.028,
                                            color: const Color(0xFF222222),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFA6AEB0),
                                                width: 2,
                                                style: BorderStyle.solid),
                                          ),
                                          labelText: 'Address',
                                          hintText: 'Enter Your Address',
                                          hintStyle: TextStyle(
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.002,
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFA6AEB0),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
                                                    0.043,
                                          ),
                                          labelStyle: TextStyle(
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF222222),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
                                                    0.045,
                                          ),
                                          suffixIconColor: const Color.fromARGB(
                                              255, 255, 0, 0),
                                        ),
                                        style: TextStyle(
                                          fontSize:
                                              UiHelper.displayWidth(context) *
                                                  0.045,
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFA6AEB0),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Location field cannot be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: TextFormField(
                                        controller: _phoneController,
                                        maxLines: 1,
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.phone_rounded,
                                            size: UiHelper.displayHeight(
                                                    context) *
                                                0.028,
                                            color: const Color(0xFF222222),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFA6AEB0),
                                                width: 2,
                                                style: BorderStyle.solid),
                                          ),
                                          labelText: 'Mobile Number',
                                          hintText: 'Enter Your Mobile Number',
                                          hintStyle: TextStyle(
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.002,
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFA6AEB0),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
                                                    0.043,
                                          ),
                                          labelStyle: TextStyle(
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF222222),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
                                                    0.045,
                                          ),
                                          suffixIconColor: const Color.fromARGB(
                                              255, 255, 0, 0),
                                        ),
                                        style: TextStyle(
                                          fontSize:
                                              UiHelper.displayWidth(context) *
                                                  0.045,
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFA6AEB0),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Mobile Number field cannot be empty';
                                          } else if (!RegExp(r'^[0-9]{10}$')
                                              .hasMatch(value)) {
                                            return 'Please enter a valid 10-digit mobile number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: TextFormField(
                                        controller: _ageController,
                                        maxLines: 1,
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFA6AEB0),
                                                width: 2,
                                                style: BorderStyle.solid),
                                          ),
                                          labelText: 'Age',
                                          hintText: 'Enter Your Age',
                                          hintStyle: TextStyle(
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.002,
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFA6AEB0),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
                                                    0.043,
                                          ),
                                          labelStyle: TextStyle(
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF222222),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
                                                    0.045,
                                          ),
                                          suffixIconColor: const Color.fromARGB(
                                              255, 255, 0, 0),
                                        ),
                                        style: TextStyle(
                                          fontSize:
                                              UiHelper.displayWidth(context) *
                                                  0.045,
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFA6AEB0),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Age field cannot be empty';
                                          }
                                          if (int.tryParse(value) == null) {
                                            return 'Age must be a valid number';
                                          }
                                          final age = int.parse(value);
                                          if (age < 6 || age > 100) {
                                            return 'Age must be between 6 and 100';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: TextFormField(
                                          controller: _genController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFA6AEB0),
                                                  width: 2,
                                                  style: BorderStyle.solid),
                                            ),
                                            suffixIcon: Icon(
                                              Icons.person,
                                              size: UiHelper.displayHeight(
                                                      context) *
                                                  0.03,
                                              color: const Color(0xFF222222),
                                            ),
                                            labelText: 'Select Gender',
                                            hintText: 'Select Gender',
                                            hintStyle: TextStyle(
                                              height: UiHelper.displayHeight(
                                                      context) *
                                                  0.002,
                                              fontFamily: "Mulish",
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFFA6AEB0),
                                              fontSize: UiHelper.displayWidth(
                                                      context) *
                                                  0.043,
                                            ),
                                            labelStyle: TextStyle(
                                              fontFamily: "Mulish",
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF222222),
                                              fontSize: UiHelper.displayWidth(
                                                      context) *
                                                  0.045,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please select a gender';
                                            }
                                            return null;
                                          },
                                          onTap: () async {
                                            final selectedGender =
                                                await showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Select Gender'),
                                                  content:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    value: dropdownvalue,
                                                    focusColor:
                                                        const Color(0xFF9BC2F2),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        dropdownvalue =
                                                            newValue!;
                                                        _genController.text =
                                                            newValue;
                                                      });
                                                      Navigator.of(context)
                                                          .pop(newValue);
                                                    },
                                                    items: items
                                                        .map((String item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: item,
                                                        child: Text(item),
                                                      );
                                                    }).toList(),
                                                  ),
                                                );
                                              },
                                            );

                                            if (selectedGender != null) {
                                              setState(() {
                                                _genController.text =
                                                    selectedGender;
                                              });
                                            }
                                          }),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: TextFormField(
                                        controller: _vehnameController,
                                        maxLines: 1,
                                        cursorColor: Colors.black,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.directions_bus_rounded,
                                            size: UiHelper.displayHeight(
                                                    context) *
                                                0.028,
                                            color: const Color(0xFF222222),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFA6AEB0),
                                                width: 2,
                                                style: BorderStyle.solid),
                                          ),
                                          labelText: 'Vehicle Name',
                                          hintText: 'Enter Your Vehicle Name',
                                          hintStyle: TextStyle(
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.002,
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFA6AEB0),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
                                                    0.043,
                                          ),
                                          labelStyle: TextStyle(
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF222222),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
                                                    0.045,
                                          ),
                                          suffixIconColor: const Color.fromARGB(
                                              255, 255, 0, 0),
                                        ),
                                        style: TextStyle(
                                          fontSize:
                                              UiHelper.displayWidth(context) *
                                                  0.045,
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFA6AEB0),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Vehicle Name field cannot be empty';
                                          }

                                          final nameRegExp = RegExp(
                                              r'^[A-Za-z]+(?:\s[A-Za-z]+)*$');
                                          if (!nameRegExp.hasMatch(value)) {
                                            return 'Please enter a valid vehicle name';
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: TextFormField(
                                          controller: _typeController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFA6AEB0),
                                                  width: 2,
                                                  style: BorderStyle.solid),
                                            ),
                                            suffixIcon: Icon(
                                              Icons.person,
                                              size: UiHelper.displayHeight(
                                                      context) *
                                                  0.03,
                                              color: const Color(0xFF222222),
                                            ),
                                            labelText: 'Select Vehicle Type',
                                            hintText: 'Select Vehicle Type',
                                            hintStyle: TextStyle(
                                              height: UiHelper.displayHeight(
                                                      context) *
                                                  0.002,
                                              fontFamily: "Mulish",
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFFA6AEB0),
                                              fontSize: UiHelper.displayWidth(
                                                      context) *
                                                  0.043,
                                            ),
                                            labelStyle: TextStyle(
                                              fontFamily: "Mulish",
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF222222),
                                              fontSize: UiHelper.displayWidth(
                                                      context) *
                                                  0.045,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please select a vehicle';
                                            }
                                            return null;
                                          },
                                          onTap: () async {
                                            final selectedGender =
                                                await showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Select Vehicle Type'),
                                                  contentTextStyle: TextStyle(
                                                      fontSize:
                                                          UiHelper.displayWidth(
                                                                  context) *
                                                              0.045,
                                                      fontFamily: "Mulish",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xFFA6AEB0)),
                                                  content:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    value: drop,
                                                    focusColor:
                                                        const Color(0xFF9BC2F2),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        drop = newValue!;
                                                        _typeController.text =
                                                            newValue;
                                                      });
                                                      Navigator.of(context)
                                                          .pop(newValue);
                                                    },
                                                    items: vehicle
                                                        .map((String item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: item,
                                                        child: Text(item),
                                                      );
                                                    }).toList(),
                                                  ),
                                                );
                                              },
                                            );

                                            if (selectedGender != null) {
                                              setState(() {
                                                _typeController.text =
                                                    selectedGender;
                                              });
                                            }
                                          }),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: TextFormField(
                                        controller: _numController,
                                        maxLines: 1,
                                        cursorColor: Colors.black,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.edit,
                                            size: UiHelper.displayHeight(
                                                    context) *
                                                0.028,
                                            color: const Color(0xFF222222),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFA6AEB0),
                                                width: 2,
                                                style: BorderStyle.solid),
                                          ),
                                          labelText: 'Vehicle Number',
                                          hintText: 'Enter Your Vehicle Number',
                                          hintStyle: TextStyle(
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.002,
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFA6AEB0),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
                                                    0.043,
                                          ),
                                          labelStyle: TextStyle(
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF222222),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
                                                    0.045,
                                          ),
                                          suffixIconColor: const Color.fromARGB(
                                              255, 255, 0, 0),
                                        ),
                                        style: TextStyle(
                                          fontSize:
                                              UiHelper.displayWidth(context) *
                                                  0.045,
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFA6AEB0),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Vehicle Number field cannot be empty';
                                          }
                                          // Add additional validation logic if needed
                                          final pattern = RegExp(
                                              r'^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9]+$');
                                          if (!pattern.hasMatch(value)) {
                                            return 'Please enter a valid vehicle number';
                                          }
                                          return null; // Return null to indicate the input is valid
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: TextFormField(
                                          controller: _facController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFA6AEB0),
                                                  width: 2,
                                                  style: BorderStyle.solid),
                                            ),
                                            suffixIcon: Icon(
                                              Icons.person,
                                              size: UiHelper.displayHeight(
                                                      context) *
                                                  0.03,
                                              color: const Color(0xFF222222),
                                            ),
                                            labelText:
                                                'Select Vehicle Facility',
                                            hintText: 'Select Vehicle Facility',
                                            hintStyle: TextStyle(
                                              height: UiHelper.displayHeight(
                                                      context) *
                                                  0.002,
                                              fontFamily: "Mulish",
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFFA6AEB0),
                                              fontSize: UiHelper.displayWidth(
                                                      context) *
                                                  0.043,
                                            ),
                                            labelStyle: TextStyle(
                                              fontFamily: "Mulish",
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF222222),
                                              fontSize: UiHelper.displayWidth(
                                                      context) *
                                                  0.045,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please select a vehicle facility';
                                            }
                                            return null;
                                          },
                                          onTap: () async {
                                            final selectedGender =
                                                await showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Select Vehicle Facility'),
                                                  contentTextStyle: TextStyle(
                                                      fontSize:
                                                          UiHelper.displayWidth(
                                                                  context) *
                                                              0.045,
                                                      fontFamily: "Mulish",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xFFA6AEB0)),
                                                  content:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    value: pin,
                                                    focusColor:
                                                        const Color(0xFF9BC2F2),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        pin = newValue!;
                                                        _facController.text =
                                                            newValue;
                                                      });
                                                      Navigator.of(context)
                                                          .pop(newValue);
                                                    },
                                                    items: vehicle2
                                                        .map((String item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: item,
                                                        child: Text(item),
                                                      );
                                                    }).toList(),
                                                  ),
                                                );
                                              },
                                            );

                                            if (selectedGender != null) {
                                              setState(() {
                                                _facController.text =
                                                    selectedGender;
                                              });
                                            }
                                          }),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: TextFormField(
                                        controller: _seatController,
                                        maxLines: 1,
                                        cursorColor: Colors.black,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.event_seat_rounded,
                                            size: UiHelper.displayHeight(
                                                    context) *
                                                0.028,
                                            color: const Color(0xFF222222),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFA6AEB0),
                                                width: 2,
                                                style: BorderStyle.solid),
                                          ),
                                          labelText: 'Vehicle Seats',
                                          hintText:
                                              'Enter Number of Vehicle Seats',
                                          hintStyle: TextStyle(
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.002,
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFA6AEB0),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
                                                    0.043,
                                          ),
                                          labelStyle: TextStyle(
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF222222),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
                                                    0.045,
                                          ),
                                          suffixIconColor: const Color.fromARGB(
                                              255, 255, 0, 0),
                                        ),
                                        style: TextStyle(
                                          fontSize:
                                              UiHelper.displayWidth(context) *
                                                  0.045,
                                          fontFamily: "Mulish",
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFA6AEB0),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Vehicle Seats field cannot be empty';
                                          }
                                          if (int.tryParse(value) == null) {
                                            return 'Vehicle Seats must be a valid number';
                                          }
                                          final age = int.parse(value);
                                          if (age < 1 || age > 50) {
                                            return 'Vehicle Seats must be between 1 and 50';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 13),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _dobController,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  const Color(0xFFFFFFFF),
                                              suffixIcon: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 00),
                                                child: Icon(
                                                  Icons.calendar_month_rounded,
                                                  size: UiHelper.displayHeight(
                                                          context) *
                                                      0.028,
                                                  color:
                                                      const Color(0xFF222222),
                                                ),
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFA6AEB0),
                                                    width: 2,
                                                    style: BorderStyle.solid),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      right: 18.5),
                                              labelText: 'Date of Birth',
                                              labelStyle: TextStyle(
                                                fontFamily: "Mulish",
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFF222222),
                                                fontSize: UiHelper.displayWidth(
                                                        context) *
                                                    0.045,
                                              ),
                                              suffixIconColor:
                                                  const Color.fromARGB(
                                                      255, 255, 0, 0),
                                            ),
                                            style: TextStyle(
                                              fontSize: UiHelper.displayWidth(
                                                      context) *
                                                  0.045,
                                              fontFamily: "Mulish",
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFFA6AEB0),
                                            ),
                                            onTap: () async {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());
                                              final DateTime? date =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime.now(),
                                              );
                                              if (date != null) {
                                                _dobController.text =
                                                    DateFormat("yyyy-MM-dd")
                                                        .format(date);
                                                dob = date;
                                              }
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please select your date of birth';
                                              }
                                              // Add any additional validation logic for the date if needed
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height:
                                        UiHelper.displayHeight(context) * 0.027,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 17,
                                        ),
                                        child: SizedBox(
                                          height:
                                              UiHelper.displayHeight(context) *
                                                  0.069,
                                          width:
                                              UiHelper.displayWidth(context) *
                                                  0.32,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(
                                                  0xFF0062DE), //background color of button
                                              //border width and color

                                              shape: RoundedRectangleBorder(
                                                  //to set border radius to button
                                                  borderRadius:
                                                      BorderRadius.circular(3)),
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _resetPassword();
                                              }
                                            },
                                            child: Text(
                                              "Save",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                height: UiHelper.displayHeight(
                                                        context) *
                                                    0.001,
                                                fontFamily:
                                                    "ZenKakuGothicAntique",
                                                fontWeight: FontWeight.w600,
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: UiHelper.displayWidth(
                                                        context) *
                                                    0.048,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: SizedBox(
                                          height:
                                              UiHelper.displayHeight(context) *
                                                  0.069,
                                          width:
                                              UiHelper.displayWidth(context) *
                                                  0.32,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                    0xFFFFFFFF), //background color of button
                                                //border width and color

                                                shape: RoundedRectangleBorder(
                                                    //to set border radius to button
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                              ),
                                              child: Text(
                                                "Cancel",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  height:
                                                      UiHelper.displayHeight(
                                                              context) *
                                                          0.001,
                                                  fontFamily:
                                                      "ZenKakuGothicAntique",
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFFA6AEB0),
                                                  fontSize:
                                                      UiHelper.displayWidth(
                                                              context) *
                                                          0.048,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/line11');
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
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
        size.width / 2, size.height / 1.85, size.width, size.height * 0.55);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
