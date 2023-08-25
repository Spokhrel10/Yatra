import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/helpers/ui_helper.dart';

class RUsersScreen extends StatefulWidget {
  const RUsersScreen({Key? key}) : super(key: key);

  @override
  _RUsersScreenState createState() => _RUsersScreenState();
}

class _RUsersScreenState extends State<RUsersScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController dobController3 = TextEditingController();
  TextEditingController dobController2 = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController timeController2 = TextEditingController();
  TextEditingController priceController = TextEditingController();

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final fireStore =
      FirebaseFirestore.instance.collection('urentals').snapshots();

  final _storage = const FlutterSecureStorage();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  var num = 1;
  late CollectionReference ticketsRef;
  late Stream<QuerySnapshot> fireStores;

  String username = "";
  DateTime? dob2;
  String vehiclename = "";
  String locat = "";
  String emailing = "";
  String phonenumber = "";
  String gen = "";
  String aging = "";

  String dobing = "";
  final int _currentIndex = 1;

  String vehiclefacility = "";
  String arrival1 = "";
  final List<Map<String, dynamic>> _dataList = [];
  String arrive1 = "";
  String date1 = "";
  String email = "";
  String name = "";
  String phone = "";
  String seats8 = "";
  String vehicle = "";
  String depart1 = "";
  String departure1 = "";
  String price1 = "";
  String seats1 = "";

  var isLoading = true;

  Future<void> _savedData2() async {
    final vehName = await _storage.read(key: 'vehicle_name');
    print(vehName);

    final snapshot = await db
        .collection("user_checkout")
        .where('vehicle', isEqualTo: vehName)
        .get();

    final vehicleOwners = snapshot.docs.map((doc) => doc.data()).toList();

    if (vehicleOwners.isNotEmpty) {
      // check if there is at least one document in the snapshot
      final data = vehicleOwners.first;

      final arrival = data['email'];
      final arrive = data['full_name'];
      final date = data['phone'].toString();
      final seats = data['seats'].toString();
      final veh = data['vehicle'];

      await _storage.write(key: 'full_name', value: arrive);
      await _storage.write(key: 'phone', value: date);
      await _storage.write(key: 'seats', value: seats);
      await _storage.write(key: 'email', value: arrival);
      await _storage.write(key: 'vehicle', value: veh);

      setState(() {
        name = arrive;
        phone = date;
        seats8 = seats;
        email = arrival;
        vehicle = veh;
        isLoading = false;
      });
    } else {
      print('No documents found for the user');
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _savedData2();
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
          title: Text('Vehicle Rentals',
              style: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontFamily: 'ComicNeue',
                fontSize: UiHelper.displayWidth(context) * 0.055,
                fontWeight: FontWeight.w900,
              )),
        ),
        body: (name.isEmpty &&
                phone.isEmpty &&
                seats8.isEmpty &&
                email.isEmpty &&
                vehicle.isEmpty)
            ? Center(
                child: Container(
                child: LoadingAnimationWidget.hexagonDots(
                  size: UiHelper.displayWidth(context) * 0.08,
                  color: const Color(0xFF0062DE),
                ),
              ))
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
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
                              height: 0.75.h,
                            ),
                            Text("YOUR VEHICLE HAS BEEN RENTED!!",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.sourceSansPro(
                                    height: 0.35.h,
                                    letterSpacing: 2.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF4E93E8),
                                    fontSize: 18.sp)),
                            Container(
                              height: 3.4.h,
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
                                maxLines: 1,
                                readOnly: true,
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
                                  hintText: name,
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
                                maxLines: 1,
                                readOnly: true,
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
                                  hintText: email,
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
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: SizedBox(
                                width: 80.w,
                                child: TextFormField(
                                  readOnly: true,
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
                                    hintText: phone,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ));
  }
}
