import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/helpers/ui_helper.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
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
      FirebaseFirestore.instance.collection('bookings').snapshots();

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
  int _currentIndex = 1;

  String vehiclefacility = "";
  String arrival1 = "";
  List<Map<String, dynamic>> _dataList = [];
  String arrive1 = "";
  String date1 = "";
  String depart1 = "";
  String departure1 = "";
  String price1 = "";
  String seats1 = "";

  var isLoading = true;

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

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _savedData();
    _getDataList();
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
        title: Text('Passengers',
            style: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontFamily: 'ComicNeue',
              fontSize: UiHelper.displayWidth(context) * 0.055,
              fontWeight: FontWeight.w900,
            )),
      ),
      body: _dataList.isEmpty
          ? Center(
              child: Container(
              child: LoadingAnimationWidget.hexagonDots(
                size: UiHelper.displayWidth(context) * 0.08,
                color: const Color(0xFF0062DE),
              ),
            ))
          : ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: (BuildContext context, int index) {
                final data = _dataList[index];
                final arrival = data['arrival'];
                final arrive = data['arrive'];
                final date = data['date'];
                final seats = data['seats'];
                final vehicle = data['vehicle'];
                final circleIndex = _currentIndex++;
                return ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: UiHelper.displayHeight(context) * 0.015,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 6.w,
                              backgroundColor:
                                  const Color(0xFF0062DE).withOpacity(0.7),
                              child: Text(
                                '${index + 1}',
                                style:
                                    const TextStyle(color: Color(0xFFFFFFFF)),
                              )),
                          SizedBox(
                            width: UiHelper.displayWidth(context) * 0.05,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  arrive,
                                  style: TextStyle(
                                    fontFamily: "PublicSans",
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF222222),
                                    fontSize:
                                        UiHelper.displayWidth(context) * 0.038,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: UiHelper.displayHeight(context) * 0.005,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Phone: $date",
                                  style: TextStyle(
                                    fontFamily: "PublicSans",
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF222222),
                                    fontSize:
                                        UiHelper.displayWidth(context) * 0.034,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: UiHelper.displayHeight(context) * 0.005,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Seats: $seats",
                                  style: TextStyle(
                                    fontFamily: "PublicSans",
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF222222),
                                    fontSize:
                                        UiHelper.displayWidth(context) * 0.034,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 18,
                        ),
                        height: UiHelper.displayHeight(context) * 0.0015,
                        width: UiHelper.displayWidth(context) * 1,
                        decoration: const BoxDecoration(
                            color: Color(0xFF222222),
                            borderRadius:
                                BorderRadius.all(Radius.circular(00))),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
