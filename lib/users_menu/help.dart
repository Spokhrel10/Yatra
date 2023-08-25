// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NinethScreen extends StatefulWidget {
  const NinethScreen({Key? key}) : super(key: key);

  @override
  State<NinethScreen> createState() => _NinethScreenState();
}

class _NinethScreenState extends State<NinethScreen> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0062DE),
        centerTitle: true,
        title: const Text('Help',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontFamily: 'ComicNeue',
              fontSize: 24,
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
                Get.back();
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Container(
                      child: Column(children: [
            Container(
              margin: const EdgeInsets.only(top: 14),
              child: const Text(
                "FAQs",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Color(0xFF0062DE),
                  fontSize: 14,
                  fontFamily: "BalooTammudu2",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0, bottom: 5),
              child: const Text(
                "Frequently asked questions",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Color(0xFF0062DE),
                  fontSize: 25.5,
                  height: 1.44,
                  fontFamily: "BalooTammudu2",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0),
              child: const Text(
                "Have questions? We're here to help.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  height: 0.85,
                  color: Color(0xFF0062DE),
                  fontSize: 16,
                  fontFamily: "Athiti",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Divider(
              thickness: 3.7, // thickness of the line
              indent: 0, // empty space to the leading edge of divider.
              endIndent: 0, // empty space to the trailing edge of the divider.
              color:
                  Color(0xFF0062DE), // The color to use when painting the line.
              height: 40, // The divider's height extent.
            ),
            Card(
                margin: const EdgeInsets.only(top: 0, left: 12, right: 12),
                color: const Color.fromARGB(255, 242, 243, 245),
                child: ExpansionTile(
                  title: const Text(
                    "Is your payment platform secure?",
                    style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16.8,
                        fontFamily: "Cambay",
                        fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 28,
                    color: Color(0xFF222222),
                  ),
                  children: [
                    Container(
                      color: const Color(0xFFFFFFFF),
                      height: 94,
                      width: 400,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Yes, it is the most safest payment platform ever done. Users would perform cash transactions hand \nto hand with the vehicle owner.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: "Athiti",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Card(
                margin: const EdgeInsets.only(top: 15, left: 12, right: 12),
                color: const Color.fromARGB(255, 242, 243, 245),
                child: ExpansionTile(
                  title: const Text(
                    "How do I change my account email and password?",
                    style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16.8,
                        fontFamily: "Cambay",
                        fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 28,
                    color: Color(0xFF222222),
                  ),
                  children: [
                    Container(
                      color: const Color(0xFFFFFFFF),
                      height: 118,
                      width: 400,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "You can change your password by clicking forgot \npassword and resetting your password but, you are \nnot reset your email. If you want to use another \nemail, you have to register it in the application.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: "Athiti",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Card(
                margin: const EdgeInsets.only(top: 15, left: 12, right: 12),
                color: const Color.fromARGB(255, 242, 243, 245),
                child: ExpansionTile(
                  title: const Text(
                    "How to leave a review for a driver",
                    style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16.8,
                        fontFamily: "Cambay",
                        fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 28,
                    color: Color(0xFF222222),
                  ),
                  children: [
                    Container(
                      color: const Color(0xFFFFFFFF),
                      height: 168,
                      width: 400,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Once the app immediately after the ride is completed. You will see a window where you can evaluate the driver and write a review. If you did \nnot enjoy your ride and you decide to write a \nnegative review, don’t worry - the driver will not \nsee that it was you.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: "Athiti",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Card(
                margin: const EdgeInsets.only(top: 15, left: 12, right: 12),
                color: const Color.fromARGB(255, 242, 243, 245),
                child: ExpansionTile(
                  title: const Text(
                    "How to find belongings I left behind",
                    style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16.8,
                        fontFamily: "Cambay",
                        fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 28,
                    color: Color(0xFF222222),
                  ),
                  children: [
                    Container(
                      color: const Color(0xFFFFFFFF),
                      height: 146,
                      width: 400,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "If you have left your belongings in the vehicle, write \nto us at dipeshgurung797@gmail.com. Include the \ntime and route of your ride, and if possible tell \nus the car’s make, color, and registration number. \nWe’ll help find your belongings.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: "Athiti",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Card(
                margin: const EdgeInsets.only(top: 15, left: 12, right: 12),
                color: const Color.fromARGB(255, 242, 243, 245),
                child: ExpansionTile(
                  title: const Text(
                    "Are there smoking breaks or stop-offs?",
                    style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16.8,
                        fontFamily: "Cambay",
                        fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 28,
                    color: Color(0xFF222222),
                  ),
                  children: [
                    Container(
                      color: const Color(0xFFFFFFFF),
                      height: 168,
                      width: 400,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Some of our trips have breaks planned into the \nschedule for the purposes of providing driving breaks \nand rest periods for the drivers. However, our aim is \nto get you to your destination as quickly as possible, \nwhich is why we don't schedule any other type of \nbreak.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: "Athiti",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Card(
                margin: const EdgeInsets.only(
                    top: 15, left: 12, right: 12, bottom: 15),
                color: const Color.fromARGB(255, 242, 243, 245),
                child: ExpansionTile(
                  title: const Text(
                    "I’m running a little late. Will the vehicle wait for me?",
                    style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16.8,
                        fontFamily: "Cambay",
                        fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 28,
                    color: Color(0xFF222222),
                  ),
                  children: [
                    Container(
                      color: const Color(0xFFFFFFFF),
                      height: 217,
                      width: 400,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Unfortunately, the vehicle cannot wait for delayed \npassengers. Our vehicles travel within a network and \nare bound to a timetable. Please ensure that you are \nat the stop at least 15 minutes before departure.\n\nIf you realize that you’re not going to make it, you can cancel your ride up to 15 minutes before departure via Booking screen.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: "Athiti",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ])))),
        ],
      ),
    );
  }
}
