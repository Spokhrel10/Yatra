// ignore_for_file: unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/users/payment.dart';

import 'package:sajilo_yatra/helpers/ui_helper.dart';

class SearchScreen extends StatefulWidget {
  final String? going;
  final String? leaving;
  final String? dob;

  const SearchScreen({
    Key? key,
    this.going,
    this.leaving,
    this.dob,
  }) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController dobController3 = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime? dob2;
  final String vehicle = "";
  TextEditingController dobController2 = TextEditingController();
  final List<String> _places = [];
  bool isLoading = true;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final fireStore =
      FirebaseFirestore.instance.collection('vehicle_owners').snapshots();

  final bool _isLoading = true;
  final _storage = const FlutterSecureStorage();

  String dobing = "";
  String seats = "";
  List<Map<String, dynamic>> _dataList = [];
  List<Map<String, dynamic>> _dataList2 = [];
  String vehiclefacility = "";
  String arrival1 = "";
  String arrive1 = "";
  String d_date = "";
  String depart1 = "";
  String departure1 = "";
  String price1 = "";
  int totalSeats = 0;
  String r_date = "";
  String meet1 = "";

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
    final snapshot = await db.collection("vehicle_home").get();

    final vehicleOwners = snapshot.docs.map((doc) => doc.data()).toList();

    if (vehicleOwners.isNotEmpty) {
      // check if there is at least one document in the snapshot
      final data = vehicleOwners.first;
      final arrival = data['Arrival'];
      final arrive = data['Arrive'];
      final ddate = data['D_date'];
      final depart = data['Depart'];
      final departure = data['Departure'];
      final price = data['Price'];
      final rdate = data['R_date'];
      final meet = data['meet'];

      await _storage.write(key: 'Arrival', value: arrival);
      await _storage.write(key: 'Arrive', value: arrive);
      await _storage.write(key: 'D_date', value: ddate);
      await _storage.write(key: 'Depart', value: depart);
      await _storage.write(key: 'Departure', value: departure);
      await _storage.write(key: 'Price', value: price);
      await _storage.write(key: 'R_date', value: rdate);
      await _storage.write(key: 'meet', value: meet);

      setState(() {
        arrival1 = arrival;
        arrive1 = arrive;
        depart1 = depart;
        departure1 = departure;
        d_date = ddate;
        r_date = rdate;
        price1 = price;
        meet1 = meet;
        isLoading = false;
      });
    } else {
      print('No documents found for the user');
    }
  }

  Future<List<Map<String, dynamic>>> _savedData7() async {
    final snapshot = await db.collection("vehicle_home").get();
    final users = snapshot.docs.map((doc) => doc.data()).toList();

    final dataList2 = users.map((data) {
      final arrival = data['Arrival'];
      final arrive = data['Arrive'];
      final ddate = data['D_date'];
      final vehicle = data['Vehicle'];
      final depart = data['Depart'];
      final departure = data['Departure'];
      final price = data['Price'];
      final rdate = data['R_Date'];
      final meet = data['Meet'];

      return {
        'Arrival': arrival,
        'Arrive': arrive,
        'D_date': ddate,
        'Depart': depart,
        'Departure': departure,
        'Price': price,
        'Vehicle': vehicle,
        'R_Date': rdate,
        'Meet': meet,
      };
    }).toList();

    return dataList2;
  }

  Future<void> _getDataList8() async {
    try {
      final dataList8 = await _savedData7();
      setState(() {
        _dataList2 = dataList8;
      });
    } catch (e) {
      print('Error retrieving data: $e');
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

    _savedData();
    _getDataList();
    _savedData1();
    _savedData7();
    _getDataList8();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
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
        title: const Text('Search',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontFamily: 'Roboto Bold',
              fontSize: 22,
              height: 1.19,
              fontWeight: FontWeight.w500,
            )),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: UiHelper.displayHeight(context) * 0.256,
              color: const Color(0xFF0062DE),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 22, top: 12),
                    child: Text(
                      "Select trip",
                      style: TextStyle(
                        fontFamily: "Mulish",
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFFFFFF),
                        fontSize: UiHelper.displayWidth(context) * 0.11,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 22, top: 12),
                    child: Text(
                      "${widget.leaving?.split(',')[0].trim().toUpperCase()} TO ${widget.going?.split(',')[0].trim().toUpperCase()}",
                      style: TextStyle(
                        fontFamily: "PublicSans",
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFFFFFF),
                        fontSize: UiHelper.displayWidth(context) * 0.035,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: dobController3,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 49, 121, 215),
                            prefixIcon: Icon(
                              Icons.calendar_month_rounded,
                              size: UiHelper.displayWidth(context) * 0.075,
                              color: const Color(0xFFFFFFFF),
                            ),
                            suffixIcon: Icon(
                              Icons.arrow_drop_down_rounded,
                              size: UiHelper.displayWidth(context) * 0.1,
                              color: const Color(0xFFFFFFFF),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 49, 121, 215),
                                  width: 0,
                                  style: BorderStyle.solid),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 49, 121, 215),
                                  width: 0,
                                  style: BorderStyle.solid),
                            ),
                            prefixIconColor:
                                const Color.fromARGB(255, 255, 0, 0),
                          ),
                          style: const TextStyle(
                              fontSize: 18,
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF)),
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
                              dobController3.text =
                                  DateFormat("yyyy-MM-dd").format(date);

                              // Check if the selected date is not today's date
                              if (date != DateTime.now()) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  text: 'There is no data of that date!!',
                                  confirmBtnColor: const Color(0xFF0062DE),
                                );
                                setState(() {
                                  dobController3.text = widget.dob!;
                                });
                              } else {
                                dob2 = DateTime.parse(d_date);
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
            Container(
              height: UiHelper.displayHeight(context) * 0.628,
              color: const Color(0xFF9BC2F2),
              child: StreamBuilder<QuerySnapshot>(
                  stream: fireStore,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Container(
                        child: LoadingAnimationWidget.hexagonDots(
                          size: UiHelper.displayWidth(context) * 0.08,
                          color: const Color(0xFF0062DE),
                        ),
                      ));
                    }
                    if (snapshot.hasError) {
                      return const Text("Some error");
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final vehicleName =
                              snapshot.data!.docs[index]['vehicle_name'];
                          print(_dataList2);
                          final data = _dataList2.firstWhere(
                            (element) => element['Vehicle'] == vehicleName,
                            orElse: () => {
                              'Arrival': '',
                              'Arrive': '',
                              'D_date': '',
                              'Depart': '',
                              'Departure': '',
                              'Price': '',
                              'R_date': '',
                              'meet': '',
                            },
                          );

                          final arrival = data['Arrival'];
                          final arrive = data['Arrive'];
                          final ddate = data['D_date'];
                          final depart = data['Depart'];
                          final departure = data['Departure'];
                          final price = data['Price'];
                          final rdate = data['R_Date'];
                          final meet = data['Meet'];
                          // Convert the string representation of time to a DateTime object
                          final departTime = DateFormat.jm().parse(depart);

// Subtract 15 minutes from the departTime
                          final earlierTime =
                              departTime.subtract(const Duration(minutes: 15));

// Format the earlierTime back to a string representation
                          final earlierTimeFormatted =
                              DateFormat.jm().format(earlierTime);
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Payment(
                                        leaving: dobController2.text,
                                        going: dobController.text,
                                        userId: '',
                                        veh: snapshot.data!.docs[index]
                                            ['vehicle_name'],
                                        fac: snapshot.data!.docs[index]
                                            ['vehicle_facility'],
                                        arrive: arrive,
                                        depart: depart,
                                        date: ddate,
                                        price: price),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    UiHelper.verticalSpace(
                                        vspace: Spacing.small),
                                    Container(
                                      margin: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        snapshot.data!.docs[index]
                                            ['vehicle_name'],
                                        style: TextStyle(
                                          fontFamily: "PublicSans",
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFFFFFFF),
                                          fontSize:
                                              UiHelper.displayWidth(context) *
                                                  0.047,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: UiHelper.displayHeight(context) *
                                          0.013,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        snapshot.data!.docs[index]
                                            ['vehicle_facility'],
                                        style: TextStyle(
                                          fontFamily: "PublicSans",
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF222222),
                                          fontSize:
                                              UiHelper.displayWidth(context) *
                                                  0.038,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: UiHelper.displayHeight(context) *
                                          0.017,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 4),
                                          child: Text(
                                            depart,
                                            style: TextStyle(
                                              fontFamily: "PublicSans",
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF222222),
                                              fontSize: UiHelper.displayWidth(
                                                      context) *
                                                  0.036,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 8, bottom: 2),
                                          height:
                                              UiHelper.displayHeight(context) *
                                                  0.01,
                                          width:
                                              UiHelper.displayWidth(context) *
                                                  0.02,
                                          decoration: const BoxDecoration(
                                              color: Color(0xFF222222),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(70))),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            left: 0,
                                            bottom: 2,
                                          ),
                                          height:
                                              UiHelper.displayHeight(context) *
                                                  0.0035,
                                          width:
                                              UiHelper.displayWidth(context) *
                                                  0.07,
                                          decoration: const BoxDecoration(
                                              color: Color(0xFF222222),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(00))),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            left: 0,
                                            bottom: 2,
                                          ),
                                          height:
                                              UiHelper.displayHeight(context) *
                                                  0.0035,
                                          width:
                                              UiHelper.displayWidth(context) *
                                                  0.07,
                                          decoration: const BoxDecoration(
                                              color: Color(0xFF222222),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(00))),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 2),
                                          height:
                                              UiHelper.displayHeight(context) *
                                                  0.01,
                                          width:
                                              UiHelper.displayWidth(context) *
                                                  0.02,
                                          decoration: const BoxDecoration(
                                              color: Color(0xFF222222),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(70))),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 8),
                                          child: Text(
                                            arrive,
                                            style: TextStyle(
                                              fontFamily: "PublicSans",
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF222222),
                                              fontSize: UiHelper.displayWidth(
                                                      context) *
                                                  0.036,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: UiHelper.displayHeight(context) *
                                          0.014,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Meeting Point : $meet",
                                        style: TextStyle(
                                          fontFamily: "PublicSans",
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF222222),
                                          fontSize:
                                              UiHelper.displayWidth(context) *
                                                  0.036,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: UiHelper.displayHeight(context) *
                                          0.014,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Meeting Time : $earlierTimeFormatted",
                                        style: TextStyle(
                                          fontFamily: "PublicSans",
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF222222),
                                          fontSize:
                                              UiHelper.displayWidth(context) *
                                                  0.036,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 14, left: 4),
                                      height: UiHelper.displayHeight(context) *
                                          0.0007,
                                      width:
                                          UiHelper.displayWidth(context) * 0.9,
                                      decoration: const BoxDecoration(
                                          color: Color(0xFF222222),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(00))),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 15, left: 5),
                                          height:
                                              UiHelper.displayHeight(context) *
                                                  0.045,
                                          width:
                                              UiHelper.displayWidth(context) *
                                                  0.245,
                                          decoration: const BoxDecoration(
                                              color: Color(0xFF222222),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6))),
                                          child: Row(
                                            children: [
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.small),
                                              Icon(
                                                Icons.event_seat_rounded,
                                                color: const Color(0xFFFFFFFF),
                                                size: UiHelper.displayWidth(
                                                        context) *
                                                    0.05,
                                              ),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.small),
                                              Text(
                                                "${int.parse(snapshot.data!.docs[index]['vehicle_seats'].toString()) - totalSeats} Seats",
                                                style: TextStyle(
                                                  fontFamily: "PublicSans",
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                  fontSize:
                                                      UiHelper.displayWidth(
                                                              context) *
                                                          0.034,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(width: 41.3.w),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 12.5),
                                          child: Text(
                                            "Rs: $price",
                                            style: TextStyle(
                                              fontFamily: "PublicSans",
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF222222),
                                              fontSize: UiHelper.displayWidth(
                                                      context) *
                                                  0.043,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 13.75, left: 8),
                                          width:
                                              UiHelper.displayWidth(context) *
                                                  0.06,
                                          height:
                                              UiHelper.displayHeight(context) *
                                                  0.03,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFFFFFFF),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(13.8)),
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size:
                                                UiHelper.displayWidth(context) *
                                                    0.036,
                                            color: const Color(0xFF0062DE),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 18,
                                      ),
                                      height: UiHelper.displayHeight(context) *
                                          0.0015,
                                      width: UiHelper.displayWidth(context) * 1,
                                      decoration: const BoxDecoration(
                                          color: Color(0xFF222222),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(00))),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
