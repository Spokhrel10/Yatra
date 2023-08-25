// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

import 'package:sajilo_yatra/helpers/ui_helper.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String? grade;
  String? product;
  var num = 1;
  String? thickness;
  String? price;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0062DE),
        centerTitle: true,
        title: const Text('Menu',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontFamily: 'ComicNeue',
              fontSize: 24,
              fontWeight: FontWeight.w900,
            )),
        elevation: 0,
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              height: UiHelper.displayHeight(context) * 0.019,
              color: const Color(0xFFEFEEF3),
            ),
            ListTile(
                leading: Icon(
                  Icons.edit_document,
                  color: const Color(0xFF0062DE),
                  size: UiHelper.displayWidth(context) * 0.07,
                ),
                title: Text('Write Feedback',
                    style: TextStyle(
                        color: const Color(0xFF222222),
                        fontFamily: "NotoSans",
                        fontSize: UiHelper.displayWidth(context) * 0.04,
                        fontWeight: FontWeight.w400)),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: const Color(0xFFD6D6D6),
                  size: UiHelper.displayWidth(context) * 0.08,
                ),
                onTap: (() {
                  Navigator.pushNamed(context, '/ninetenth');
                })),
            UiHelper.verticalSpace(vspace: Spacing.xxsmall),
            Container(
              height: UiHelper.displayHeight(context) * 0.0015,
              color: const Color(0xFFD6D6D6),
            ),
            ListTile(
                leading: Icon(
                  Icons.info_outline_rounded,
                  color: const Color(0xFF0062DE),
                  size: UiHelper.displayWidth(context) * 0.07,
                ),
                title: Text('About Us',
                    style: TextStyle(
                        color: const Color(0xFF222222),
                        fontFamily: "NotoSans",
                        fontSize: UiHelper.displayWidth(context) * 0.04,
                        fontWeight: FontWeight.w400)),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: const Color(0xFFD6D6D6),
                  size: UiHelper.displayWidth(context) * 0.08,
                ),
                onTap: (() {
                  Get.toNamed('/line22');
                })),
            UiHelper.verticalSpace(vspace: Spacing.xxsmall),
            Container(
              height: UiHelper.displayHeight(context) * 0.0015,
              color: const Color(0xFFD6D6D6),
            ),
            ListTile(
                leading: Icon(
                  Icons.phone,
                  color: const Color(0xFF0062DE),
                  size: UiHelper.displayWidth(context) * 0.07,
                ),
                title: Text('Contact Us',
                    style: TextStyle(
                        color: const Color(0xFF222222),
                        fontFamily: "NotoSans",
                        fontSize: UiHelper.displayWidth(context) * 0.04,
                        fontWeight: FontWeight.w400)),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: const Color(0xFFD6D6D6),
                  size: UiHelper.displayWidth(context) * 0.08,
                ),
                onTap: (() {
                  Navigator.pushNamed(context, '/line23');
                })),
            UiHelper.verticalSpace(vspace: Spacing.xxsmall),
            Container(
              height: UiHelper.displayHeight(context) * 0.0015,
              color: const Color(0xFFD6D6D6),
            ),
            ListTile(
                leading: Icon(
                  Icons.help,
                  color: const Color(0xFF0062DE),
                  size: UiHelper.displayWidth(context) * 0.07,
                ),
                title: Text('Help',
                    style: TextStyle(
                        color: const Color(0xFF222222),
                        fontFamily: "NotoSans",
                        fontSize: UiHelper.displayWidth(context) * 0.04,
                        fontWeight: FontWeight.w400)),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: const Color(0xFFD6D6D6),
                  size: UiHelper.displayWidth(context) * 0.08,
                ),
                onTap: (() {
                  Navigator.pushNamed(context, '/line24');
                })),
            UiHelper.verticalSpace(vspace: Spacing.xxsmall),
            Container(
              height: UiHelper.displayHeight(context) * 0.0015,
              color: const Color(0xFFD6D6D6),
            ),
            ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  color: const Color(0xFF0062DE),
                  size: UiHelper.displayWidth(context) * 0.07,
                ),
                title: Text('LogOut',
                    style: TextStyle(
                        color: const Color(0xFF222222),
                        fontFamily: "NotoSans",
                        fontSize: UiHelper.displayWidth(context) * 0.04,
                        fontWeight: FontWeight.w400)),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: const Color(0xFFD6D6D6),
                  size: UiHelper.displayWidth(context) * 0.08,
                ),
                onTap: (() {
                  QuickAlert.show(
                    context: context,
                    onConfirmBtnTap: () {
                      Get.offAllNamed('/second');
                    },
                    type: QuickAlertType.confirm,
                    text: 'Do you want to logout',
                    confirmBtnText: 'Yes',
                    cancelBtnText: 'No',
                    confirmBtnColor: const Color(0xFF0062DE),
                  );
                })),
            UiHelper.verticalSpace(vspace: Spacing.xxsmall),
            Container(
              height: UiHelper.displayHeight(context) * 0.0015,
              color: const Color(0xFFD6D6D6),
            ),
          ],
        ),
      ),
    );
  }
}
