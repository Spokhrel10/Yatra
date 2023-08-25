// ignore_for_file: unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quickalert/quickalert.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:sajilo_yatra/helpers/ui_helper.dart';

class VehicleTickets extends StatefulWidget {
  final String? going;
  final User? user;
  final String? leaving;
  final String? dob;
  final String? depart;
  final String? arrival;
  final String? price;
  const VehicleTickets(
      {Key? key,
      this.going,
      this.leaving,
      this.dob,
      this.depart,
      this.arrival,
      this.price,
      this.user})
      : super(key: key);

  @override
  State<VehicleTickets> createState() => _VehicleTicketsState();
}

class _VehicleTicketsState extends State<VehicleTickets> {
  int _selectedIndex = 1;
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController dobController3 = TextEditingController();
  TextEditingController dobController2 = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController timeController2 = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _storage = const FlutterSecureStorage();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final fireStore =
      FirebaseFirestore.instance.collection('vehicle_owners').snapshots();

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
  String seats = "";
  String vehiclefacility = "";
  String arrival1 = "";
  String arrive1 = "";
  List<Map<String, dynamic>> _dataList = [];
  String d_date = "";
  String depart1 = "";
  int totalSeats = 0;
  String departure1 = "";
  String price1 = "";
  String book = "";
  String r_date = "";
  String veh1 = "";

  var isLoading = true;

  void _getSavedData() async {
    final fullName = await _storage.read(key: 'full_name');
    final vehName = await _storage.read(key: 'vehicle_name');
    final vehFac = await _storage.read(key: 'vehicle_facility');
    final location = await _storage.read(key: 'location');
    final email = await _storage.read(key: 'email');
    final phoneNumber = await _storage.read(key: 'phone_number');
    final gender = await _storage.read(key: 'gender');
    final age = await _storage.read(key: 'age');
    final seat = await _storage.read(key: 'vehicle_seats');
    final dob = await _storage.read(key: 'dob');

    setState(() {
      username = fullName!;
      locat = location!;
      emailing = email!;
      phonenumber = phoneNumber!;
      gen = gender!;
      aging = age!;
      dobing = dob!;
      vehiclename = vehName!;
      vehiclefacility = vehFac!;
      seats = seat!;
      isLoading = false;
    });
  }

  Future<List<Map<String, dynamic>>> _savedData() async {
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
      final dataList = await _savedData();
      setState(() {
        _dataList = dataList;
      });
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }

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
      final arrival = data['Arrival'];
      final veh = data['Vehicle'];
      final arrive = data['Arrive'];
      final ddate = data['D_date'];
      final depart = data['Depart'];
      final departure = data['Departure'];
      final price = data['Price'];
      final booking = data['Booking'];
      final rdate = data['Meet'];

      await _storage.write(key: 'Arrival', value: arrival);
      await _storage.write(key: 'Arrive', value: arrive);
      await _storage.write(key: 'D_date', value: ddate);
      await _storage.write(key: 'Depart', value: depart);
      await _storage.write(key: 'Departure', value: departure);
      await _storage.write(key: 'Price', value: price);
      await _storage.write(key: 'Meet', value: rdate);
      await _storage.write(key: 'Booking', value: booking);
      await _storage.write(key: 'Vehicle', value: veh);

      setState(() {
        arrival1 = arrival;
        arrive1 = arrive;
        depart1 = depart;
        departure1 = departure;
        d_date = ddate;
        r_date = rdate;
        veh1 = veh;
        book = booking;
        price1 = price;

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
    dobController = TextEditingController(text: widget.going);
    dobController2 = TextEditingController(text: widget.leaving);
    dobController3 = TextEditingController(text: widget.dob);
    timeController = TextEditingController(text: widget.depart);
    timeController2 = TextEditingController(text: widget.arrival);
    priceController = TextEditingController(text: widget.price);

    _getSavedData();
    _savedData();
    _savedData1();
    _getDataList();
  }

  @override
  Widget build(BuildContext context) {
    print(totalSeats);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF0062DE),
          centerTitle: true,
          title: Text('Tickets',
              style: TextStyle(
                letterSpacing: 0.95,
                color: const Color(0xFFFFFFFF),
                fontFamily: 'ComicNeue',
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
              )),
          elevation: 0,
        ),
        body: Center(
          child: isLoading
              ? FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 3)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        child: LoadingAnimationWidget.hexagonDots(
                          size: UiHelper.displayWidth(context) * 0.08,
                          color: const Color(0xFF0062DE),
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      heightFactor: 0.6,
                                      child: Container(
                                        width: 395,
                                        height: 70,
                                        color: const Color(0xFFFFFFFF),
                                        child: const Text(
                                          "You have no ticket publications yet.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF0062DE),
                                              fontSize: 19.5,
                                              fontFamily: "Cambay",
                                              fontWeight: FontWeight.w900,
                                              height: 3.85),
                                        ),
                                      ),
                                    ),
                                    const Align(
                                      alignment: Alignment.bottomCenter,
                                      heightFactor: 1.8,
                                      widthFactor: 4.4,
                                      child: Icon(
                                        Icons.event_busy_rounded,
                                        size: 170,
                                        color: Color(0xFF222222),
                                      ),
                                    ),
                                    Container(
                                      height: 34.4,
                                      width: 140,
                                      margin:
                                          const EdgeInsets.only(bottom: 185),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF222222),

                                          shape: RoundedRectangleBorder(
                                              //to set border radius to button
                                              borderRadius: BorderRadius.circular(
                                                  12)), //background color of button
                                        ),
                                        child: const Text(
                                          "Publish Now",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              height: 1.2,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFFFFFFFF),
                                              fontSize: 16),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/line7');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  })
              : (arrival1.isNotEmpty &&
                      arrive1.isNotEmpty &&
                      depart1.isNotEmpty &&
                      departure1.isNotEmpty &&
                      price1.isNotEmpty) // check if ring list is empty
// check if ring list is empty
                  ? Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    color: const Color(0xFF0062DE),
                                    height:
                                        UiHelper.displayHeight(context) * 0.197,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 15, top: 18),
                                          child: Text(
                                            "${departure1.split(',')[0].trim().toUpperCase()} TO ${arrival1.split(',')[0].trim().toUpperCase()}",
                                            style: TextStyle(
                                              fontFamily: "PublicSans",
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFFFFFFFF),
                                              fontSize: UiHelper.displayWidth(
                                                      context) *
                                                  0.035,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 25),
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: dobController3,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor:
                                                      const Color.fromARGB(
                                                          255, 49, 121, 215),
                                                  prefixIcon: Icon(
                                                    Icons
                                                        .calendar_month_rounded,
                                                    size: UiHelper.displayWidth(
                                                            context) *
                                                        0.075,
                                                    color:
                                                        const Color(0xFFFFFFFF),
                                                  ),
                                                  hintText: d_date,
                                                  hintStyle: const TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "Mulish",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xFFFFFFFF)),
                                                  suffixIcon: Icon(
                                                    Icons
                                                        .arrow_drop_down_rounded,
                                                    size: UiHelper.displayWidth(
                                                            context) *
                                                        0.1,
                                                    color:
                                                        const Color(0xFFFFFFFF),
                                                  ),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 49, 121, 215),
                                                        width: 0,
                                                        style:
                                                            BorderStyle.solid),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 49, 121, 215),
                                                        width: 0,
                                                        style:
                                                            BorderStyle.solid),
                                                  ),
                                                  prefixIconColor:
                                                      const Color.fromARGB(
                                                          255, 255, 0, 0),
                                                ),
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: "Mulish",
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFFFFFFF)),
                                                onTap: () async {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          new FocusNode());
                                                  final DateTime? date =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1900),
                                                    lastDate: DateTime(2100),
                                                  );
                                                  if (date != null) {
                                                    dobController3.text =
                                                        DateFormat("yyyy-MM-dd")
                                                            .format(date);

                                                    // Check if the selected date is not today's date
                                                    if (date !=
                                                        DateTime.parse(
                                                            d_date)) {
                                                      QuickAlert.show(
                                                        context: context,
                                                        type: QuickAlertType
                                                            .error,
                                                        text:
                                                            'There is no data of that date!!',
                                                        confirmBtnColor:
                                                            const Color(
                                                                0xFF0062DE),
                                                      );
                                                      dobController3.text =
                                                          d_date;
                                                    } else {
                                                      dob2 = DateTime.parse(
                                                          d_date);
                                                      print(dob2);
                                                    }
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/third3');
                                    },
                                    child: Container(
                                      height: 26.7.h,
                                      color: const Color(0xFF9BC2F2),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          UiHelper.verticalSpace(
                                              vspace: Spacing.small),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 17),
                                            child: Text(
                                              veh1,
                                              style: TextStyle(
                                                fontFamily: "PublicSans",
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFFFFFFFF),
                                                fontSize: UiHelper.displayWidth(
                                                        context) *
                                                    0.047,
                                              ),
                                            ),
                                          ),
                                          UiHelper.verticalSpace(
                                              vspace: Spacing.small),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 17),
                                            child: Text(
                                              vehiclefacility,
                                              style: TextStyle(
                                                fontFamily: "PublicSans",
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF222222),
                                                fontSize: UiHelper.displayWidth(
                                                        context) *
                                                    0.038,
                                              ),
                                            ),
                                          ),
                                          UiHelper.verticalSpace(
                                              vspace: Spacing.medium),
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 17),
                                                child: Text(
                                                  depart1,
                                                  style: TextStyle(
                                                    fontFamily: "PublicSans",
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xFF222222),
                                                    fontSize:
                                                        UiHelper.displayWidth(
                                                                context) *
                                                            0.036,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 8, bottom: 2),
                                                height: UiHelper.displayHeight(
                                                        context) *
                                                    0.01,
                                                width: UiHelper.displayWidth(
                                                        context) *
                                                    0.02,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFF222222),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                70))),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  left: 0,
                                                  bottom: 2,
                                                ),
                                                height: UiHelper.displayHeight(
                                                        context) *
                                                    0.0035,
                                                width: UiHelper.displayWidth(
                                                        context) *
                                                    0.07,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFF222222),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                00))),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  left: 0,
                                                  bottom: 2,
                                                ),
                                                height: UiHelper.displayHeight(
                                                        context) *
                                                    0.0035,
                                                width: UiHelper.displayWidth(
                                                        context) *
                                                    0.07,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFF222222),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                00))),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 2),
                                                height: UiHelper.displayHeight(
                                                        context) *
                                                    0.01,
                                                width: UiHelper.displayWidth(
                                                        context) *
                                                    0.02,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFF222222),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                70))),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 8),
                                                child: Text(
                                                  arrive1,
                                                  style: TextStyle(
                                                    fontFamily: "PublicSans",
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xFF222222),
                                                    fontSize:
                                                        UiHelper.displayWidth(
                                                                context) *
                                                            0.036,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 14, left: 17),
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.0007,
                                            width:
                                                UiHelper.displayWidth(context) *
                                                    0.9,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFF222222),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(00))),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 15, left: 18),
                                                  height:
                                                      UiHelper.displayHeight(
                                                              context) *
                                                          0.045,
                                                  width: UiHelper.displayWidth(
                                                          context) *
                                                      0.245,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color(0xFF222222),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6))),
                                                  child: Row(
                                                    children: [
                                                      UiHelper.horizontaSpace(
                                                          hspace:
                                                              Spacing.small),
                                                      Icon(
                                                        Icons
                                                            .event_seat_rounded,
                                                        color: const Color(
                                                            0xFFFFFFFF),
                                                        size: UiHelper
                                                                .displayWidth(
                                                                    context) *
                                                            0.05,
                                                      ),
                                                      UiHelper.horizontaSpace(
                                                          hspace:
                                                              Spacing.small),
                                                      Text(
                                                        "${int.parse(seats)} Seats",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "PublicSans",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: const Color(
                                                              0xFFFFFFFF),
                                                          fontSize: UiHelper
                                                                  .displayWidth(
                                                                      context) *
                                                              0.034,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(width: 50.2.w),
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  margin: const EdgeInsets.only(
                                                      top: 15),
                                                  child: Text(
                                                    "Rs: $price1",
                                                    style: TextStyle(
                                                      fontFamily: "PublicSans",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xFF222222),
                                                      fontSize:
                                                          UiHelper.displayWidth(
                                                                  context) *
                                                              0.043,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 1.1.h,
                                          ),
                                          Row(
                                            children: [
                                              Container(width: 4.85.w),
                                              Text(
                                                  "Remaning Seats : ${totalSeats - int.parse(seats)}",
                                                  style: GoogleFonts.mukta(
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xFF222222),
                                                    fontSize:
                                                        UiHelper.displayWidth(
                                                                context) *
                                                            0.034,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      child: LoadingAnimationWidget.hexagonDots(
                      size: UiHelper.displayWidth(context) * 0.08,
                      color: const Color(0xFF0062DE),
                    )),
        ));
  }
}
