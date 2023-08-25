import 'dart:async';
import 'loginas.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
// ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const FirstScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF4E93E8),
      alignment: Alignment.center,
      child: Align(
        heightFactor: 0.9,
        alignment: Alignment.topCenter,
        child: Image.asset(
          'images/logos.png',
          width: 330,
          height: 315,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
