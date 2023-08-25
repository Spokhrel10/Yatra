import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:math';
import 'package:sendgrid_mailer/sendgrid_mailer.dart';

import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:sajilo_yatra/helpers/ui_helper.dart';
import '../controllers/bottom_nav_controller.dart';
import '../controllers/esewa_controller.dart';

class VPayment extends StatefulWidget {
  final String? going;
  final String? leaving;
  final String userId;
  final String? veh;
  final String? fac;

  final String? arrive;
  final String? depart;
  final String? ddate;
  final String? rdate;
  final String? price;

  final String? meet;

  const VPayment(
      {Key? key,
      this.going,
      this.leaving,
      required this.userId,
      this.veh,
      this.fac,
      this.arrive,
      this.depart,
      this.ddate,
      this.rdate,
      this.meet,
      this.price})
      : super(key: key);

  @override
  _VPaymentState createState() => _VPaymentState();
}

class _VPaymentState extends State<VPayment> {
  final _storage = const FlutterSecureStorage();
  BottomNavController bottomController = Get.put(BottomNavController());

  BottomNavController bottomNavController = Get.find<BottomNavController>();
  BottomNavController bottom = Get.put(BottomNavController());

  EsewaPaymentSuccessResult? eSuccess;
  final db = FirebaseFirestore.instance;
  String referenceId = "";
  final _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> _dataList = [];
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _seatController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final _discountController = TextEditingController();

  TextEditingController dobController = TextEditingController();
  TextEditingController dobController2 = TextEditingController();
  String? username;
  String? locat;
  String? emailing;
  String? phonenumber;
  String? gen;
  String? meet;
  String? aging;
  String? dobing;
  String? ddate;
  String? rdate;
  String? vehiclename;
  String? vehiclefacility;
  String? arrive;
  String? depart;
  String? seats;
  String? price;
  int? seats1;
  int totalSeats = 0;
  String? sprice;
  String? name1;
  String? phone1;

  Map<String, int> discountPrices = {
    "YGFJY899": 50,
    "UIGF78": 10,
    "HRDTY56": 15,
    "AKI745": 20,
    "HGHG7": 25,
    "JHVJ34": 30,
  };

  var isLoading = true;
  final bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _getSavedData();

    dobController = TextEditingController(text: widget.going);
    dobController2 = TextEditingController(text: widget.leaving);
    price = widget.price;
    vehiclename = widget.veh;
    vehiclefacility = widget.fac;
    ddate = widget.ddate;
    rdate = widget.rdate;
    arrive = widget.arrive;
    depart = widget.depart;
    meet = widget.meet;

    _savedData();
    _savedData1();
    _getDataList();
  }

  Future<List<Map<String, dynamic>>> _savedData1() async {
    final vehName = await _storage.read(key: 'vehicle_name');
    print(vehName);

    final snapshot = await db
        .collection("user_checkout")
        .where('vehicle', isEqualTo: vehName)
        .get();
    final users = snapshot.docs.map((doc) => doc.data()).toList();

    final dataList = users.map((data) {
      final arrival = data['email'];
      final arrive = data['full_name'];
      final date = data['phone'].toString();
      final seats = data['seats'].toString();
      final veh = data['vehicle'];
      totalSeats += int.parse(seats);

      return {
        'arrival': arrival,
        'arrive': arrive,
        'date': date,
        'seats': seats,
        'vehicle': veh,
      };
    }).toList();

    return dataList;
  }

  Future<void> _getDataList() async {
    try {
      final dataList = await _savedData1();
      setState(() {
        _dataList = dataList;
      });
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }

  Future<void> _savedData() async {
    vehiclename = widget.veh;
    final snapshot = await db
        .collection("vehicle_owners")
        .where('vehicle_name', isEqualTo: vehiclename)
        .get();

    final vehicleOwners = snapshot.docs.map((doc) => doc.data()).toList();

    if (vehicleOwners.isNotEmpty) {
      // check if there is at least one document in the snapshot

      // check if there is at least one document in the snapshot
      final data = vehicleOwners.first;
      final price = data['seat_price'];
      final seat = data['vehicle_seats'];
      final name = data['full_name'];
      final mobile = data['phone'];

      await _storage.write(key: 'seat_price', value: price.toString());
      await _storage.write(key: 'full_name', value: name);
      await _storage.write(key: 'phone', value: mobile);
      await _storage.write(key: 'vehicle_seats', value: seat.toString());

      setState(() {
        sprice = price.toString();
        seats = seat.toString();
        name1 = name;
        phone1 = mobile;
        isLoading = false;
      });
    } else {
      print('No documents found for the user');
    }
    print(sprice);
    seats1 = int.parse(seats.toString());
  }

  String generateBookingId() {
    var rng = Random();
    var codeUnits = List.generate(10, (index) {
      return rng.nextInt(26) +
          65; // generates a code unit between 65 and 90 (inclusive) for A-Z characters
    });

    return String.fromCharCodes(codeUnits);
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
        title: Text("${widget.leaving?.split(',')[0].trim()}",
            style: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontFamily: 'ComicNeue',
              fontSize: UiHelper.displayWidth(context) * 0.052,
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
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: Text(
                            vehiclename!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Cambay",
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0062DE),
                              fontSize: UiHelper.displayWidth(context) * 0.065,
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              controller: _nameController,
                              maxLines: 1,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.edit,
                                  size: UiHelper.displayHeight(context) * 0.028,
                                  color: const Color(0xFF222222),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFA6AEB0),
                                      width: 2,
                                      style: BorderStyle.solid),
                                ),
                                labelText: 'Full Name',
                                hintText: 'Enter Your Full Name',
                                hintStyle: TextStyle(
                                  height:
                                      UiHelper.displayHeight(context) * 0.002,
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFA6AEB0),
                                  fontSize:
                                      UiHelper.displayWidth(context) * 0.043,
                                ),
                                labelStyle: TextStyle(
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF222222),
                                  fontSize:
                                      UiHelper.displayWidth(context) * 0.045,
                                ),
                                suffixIconColor:
                                    const Color.fromARGB(255, 255, 0, 0),
                              ),
                              style: TextStyle(
                                fontSize:
                                    UiHelper.displayWidth(context) * 0.045,
                                fontFamily: "Mulish",
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFA6AEB0),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Full Name field cannot be empty';
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
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              controller: _emailController,
                              maxLines: 1,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.mail_rounded,
                                  size: UiHelper.displayHeight(context) * 0.028,
                                  color: const Color(0xFF222222),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFA6AEB0),
                                      width: 2,
                                      style: BorderStyle.solid),
                                ),
                                labelText: 'Email',
                                hintText: 'Enter Your Email',
                                hintStyle: TextStyle(
                                  height:
                                      UiHelper.displayHeight(context) * 0.002,
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFA6AEB0),
                                  fontSize:
                                      UiHelper.displayWidth(context) * 0.043,
                                ),
                                labelStyle: TextStyle(
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF222222),
                                  fontSize:
                                      UiHelper.displayWidth(context) * 0.045,
                                ),
                                suffixIconColor:
                                    const Color.fromARGB(255, 255, 0, 0),
                              ),
                              style: TextStyle(
                                fontSize:
                                    UiHelper.displayWidth(context) * 0.045,
                                fontFamily: "Mulish",
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFA6AEB0),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email field cannot be empty';
                                } else if (!value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              controller: _phoneController,
                              maxLines: 1,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.phone,
                                  size: UiHelper.displayHeight(context) * 0.028,
                                  color: const Color(0xFF222222),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFA6AEB0),
                                      width: 2,
                                      style: BorderStyle.solid),
                                ),
                                labelText: 'Phone Number',
                                hintText: 'Enter Your Phone Number',
                                hintStyle: TextStyle(
                                  height:
                                      UiHelper.displayHeight(context) * 0.002,
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFA6AEB0),
                                  fontSize:
                                      UiHelper.displayWidth(context) * 0.043,
                                ),
                                labelStyle: TextStyle(
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF222222),
                                  fontSize:
                                      UiHelper.displayWidth(context) * 0.045,
                                ),
                                suffixIconColor:
                                    const Color.fromARGB(255, 255, 0, 0),
                              ),
                              style: TextStyle(
                                fontSize:
                                    UiHelper.displayWidth(context) * 0.045,
                                fontFamily: "Mulish",
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFA6AEB0),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Phone Number field cannot be empty';
                                } else if (!RegExp(r'^[0-9]{10}$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid 10-digit phone number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              controller: _priceController,
                              maxLines: 1,
                              readOnly: true,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.currency_rupee_rounded,
                                  size: UiHelper.displayHeight(context) * 0.028,
                                  color: const Color(0xFF222222),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFA6AEB0),
                                      width: 2,
                                      style: BorderStyle.solid),
                                ),
                                labelText: 'Price',
                                hintText: 'Rs: $price',
                                hintStyle: TextStyle(
                                  height:
                                      UiHelper.displayHeight(context) * 0.002,
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFA6AEB0),
                                  fontSize:
                                      UiHelper.displayWidth(context) * 0.043,
                                ),
                                labelStyle: TextStyle(
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF222222),
                                  fontSize:
                                      UiHelper.displayWidth(context) * 0.045,
                                ),
                                suffixIconColor:
                                    const Color.fromARGB(255, 255, 0, 0),
                              ),
                              style: TextStyle(
                                fontSize:
                                    UiHelper.displayWidth(context) * 0.045,
                                fontFamily: "Mulish",
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFA6AEB0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              controller: _discountController,
                              maxLines: 1,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.discount_rounded,
                                  size: UiHelper.displayHeight(context) * 0.028,
                                  color: const Color(0xFF222222),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFA6AEB0),
                                      width: 2,
                                      style: BorderStyle.solid),
                                ),
                                labelText: 'Discount Code (Optional)',
                                hintText: 'Enter Your Discount Code',
                                hintStyle: TextStyle(
                                  height:
                                      UiHelper.displayHeight(context) * 0.002,
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFA6AEB0),
                                  fontSize:
                                      UiHelper.displayWidth(context) * 0.043,
                                ),
                                labelStyle: TextStyle(
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF222222),
                                  fontSize:
                                      UiHelper.displayWidth(context) * 0.045,
                                ),
                                suffixIconColor:
                                    const Color.fromARGB(255, 255, 0, 0),
                              ),
                              style: TextStyle(
                                fontSize:
                                    UiHelper.displayWidth(context) * 0.045,
                                fontFamily: "Mulish",
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFA6AEB0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: UiHelper.displayHeight(context) * 0.035,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: SizedBox(
                            height: UiHelper.displayHeight(context) * 0.069,
                            width: UiHelper.displayWidth(context) * 0.1,
                            child: GetBuilder<BottomNavController>(
                                builder: (data) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                      0xFF0062DE), //background color of button
                                  //border width and color

                                  shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(3)),
                                ),
                                child: Text(
                                  "Buy Now",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    height:
                                        UiHelper.displayHeight(context) * 0.001,
                                    fontFamily: "ZenKakuGothicAntique",
                                    fontWeight: FontWeight.w600,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontSize:
                                        UiHelper.displayWidth(context) * 0.048,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate() &&
                                          _nameController.text.isNotEmpty &&
                                          _emailController.text.isNotEmpty &&
                                          _phoneController.text.isNotEmpty &&
                                          _discountController.text.isEmpty ||
                                      _discountController.text == "YGFJY899" ||
                                      _discountController.text == "UIGF78" ||
                                      _discountController.text == "HRDTY56" ||
                                      _discountController.text == "AKI745" ||
                                      _discountController.text == "HGHG7" ||
                                      _discountController.text == "JHVJ34") {
                                    db.collection('user_checkout').add({
                                      'discount': _discountController.text,
                                      'email': _emailController.text,
                                      'full_name': _nameController.text,
                                      'phone': _phoneController.text,
                                      'vehicle': vehiclename,
                                      'seats': _seatController.text,
                                    });
                                    print(sprice);

                                    int discountAmount = discountPrices[
                                            _discountController.text] ??
                                        0;
                                    int price2 =
                                        int.parse(price!) - discountAmount;
                                    final bookingId = generateBookingId();

                                    try {
                                      // send email

                                      final controller = EsewaController();
                                      controller.esewaPay(price2);
                                      db.collection('urentals').add({
                                        'city': dobController2.text,
                                        'D_date': ddate,
                                        'R_date': rdate,
                                        'arrive': arrive,
                                        'depart': depart,
                                        'seats': _seatController.text,
                                        'price': price,
                                        'meet': meet,
                                        'vehicle_facility': vehiclefacility,
                                        'vehicle_name': vehiclename,
                                        'id': bookingId
                                      });
                                      // show success message and navigate to the next screen
                                      Get.snackbar(
                                        "Payment Successful",
                                        "Rental confirmed!",
                                        backgroundColor:
                                            const Color(0xFF85bb65),
                                        colorText: Colors.grey.shade900,
                                        duration:
                                            const Duration(milliseconds: 3000),
                                        snackPosition: SnackPosition.BOTTOM,
                                        margin: const EdgeInsets.all(10),
                                        borderRadius: 10,
                                        borderWidth: 2,
                                        borderColor: const Color(0xFF85bb65),
                                        animationDuration:
                                            const Duration(milliseconds: 400),
                                      );
                                      Get.toNamed('/hun1');
                                      sendMail(bookingId);
                                    } catch (e) {
                                      print('Error sending email: $e');
                                      Get.toNamed('/hun1');
                                      // show error message if email couldn't be sent
                                    } // replace 100 with the actual price you want to charge
                                  } else {
                                    print("hello");
                                  }
                                },
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void sendMail(String bookingId) async {
    final emailing = await _storage.read(key: 'email');
    print(emailing);
    final name = await _storage.read(key: 'full_name');
    print(name);

    final mailer = Mailer(
        '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');
    var toAddress = Address(emailing!);
    const fromAddress = Address('dgisfit@gmail.com');
    final content = Content('text/plain',
        'Hello,\n\nThe vehicle ($vehiclename)  has been rented on your name ($name) from $ddate to $rdate.\nThe name of the vehicle owner is $name1 and the mobile number is $phone1.');
    final subject = 'Vehicle Rental Confirmed - $bookingId';
    var personalization = Personalization([toAddress]);

    final email =
        Email([personalization], fromAddress, subject, content: [content]);
    mailer.send(email).then((result) {
      print(result.isValue);
    });
  }
}
