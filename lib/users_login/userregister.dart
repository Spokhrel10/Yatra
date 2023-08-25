import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class SixthScreen extends StatefulWidget {
  const SixthScreen({Key? key}) : super(key: key);
  @override
  State<SixthScreen> createState() => _SixthScreenState();
}

class _SixthScreenState extends State<SixthScreen> {
  final db = FirebaseFirestore.instance;
  String? fullname;
  String? email;
  String? password;
  int? age;
  dynamic phonenumber;
  String? location;
  String? vehname;
  String? type;
  int? seat;
  int? vehnum;
  String? facility;
  String? dob;
  // Initial Selected Value
  String dropdownvalue = 'Male';

  // List of items in our dropdown menu
  var items = ['Male', 'Female', 'Others'];
  var item1 = [];
  bool _isObscure = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController vehnameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController seatController = TextEditingController();
  TextEditingController facController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  register() async {
    db.collection('users').add({
      'full_name': fullname,
      'email': email,
      'password': password,
      'gender': dropdownvalue,
      'age': age,
      'phone_number': phonenumber,
      'location': location,
      'dob': dob
    });
    Get.toNamed('/third');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: const Color(0xFF4E93E8),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 7.5.h,
                      ),
                      Image.asset(
                        "images/logos.png",
                        width: 227,
                        height: 220,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        "Sign Up to login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 0.05.h,
                            letterSpacing: 0.3,
                            fontFamily: "KumbhSans",
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFFFFFFF),
                            fontSize: 26),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 36),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9.1),
                              width: 290,
                              child: TextFormField(
                                controller: nameController,
                                maxLines: 1,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFF9BC2F2),
                                  suffixIcon: Icon(
                                    Icons.edit,
                                    color: Color(0xFF222222),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF9BC2F2),
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF9BC2F2),
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  labelText: 'Full Name',
                                  hintText: 'Enter Your Full Name',
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
                                    color: Color.fromARGB(255, 0, 0, 0)),
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
                                onChanged: (String val) {
                                  fullname = val;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 290,
                              child: TextFormField(
                                controller: emailController,
                                maxLines: 1,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFF9BC2F2),
                                  suffixIcon: Icon(
                                    Icons.mail_rounded,
                                    color: Color(0xFF222222),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF9BC2F2),
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF9BC2F2),
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  labelText: 'Email',
                                  hintText: 'Enter Your Email',
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
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email field cannot be empty';
                                  } else if (!value.contains('@')) {
                                    return 'Please enter a valid email address';
                                  } else if (!value.endsWith('@gmail.com') &&
                                      !value.endsWith('@sajiloyatra.com.np')) {
                                    return 'Email address must end with "@gmail.com", or "@sajiloyatra.com.np"';
                                  }
                                  return null;
                                },
                                onChanged: (String val) {
                                  email = val;
                                },
                              ),
                            ),
                            Container(
                              width: 290,
                              margin: const EdgeInsets.only(top: 9.1),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: _isObscure,
                                maxLines: 1,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFF9BC2F2),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: const Color(0xFF222222),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      }),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF9BC2F2),
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF9BC2F2),
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  labelText: 'Password',
                                  hintText: 'Enter Your Password',
                                  hintStyle: const TextStyle(
                                      fontFamily: "Mulish",
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF222222),
                                      fontSize: 16.7),
                                  labelStyle: const TextStyle(
                                      fontFamily: "Mulish",
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF222222),
                                      fontSize: 17.7),
                                  suffixIconColor:
                                      const Color.fromARGB(255, 255, 0, 0),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password field cannot be empty';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters long';
                                  }
                                  if (!value.contains(RegExp(r'[A-Z]'))) {
                                    return 'Password must contain at least one uppercase letter';
                                  }
                                  if (!value.contains(RegExp(r'[0-9]'))) {
                                    return 'Password must contain at least one digit';
                                  }
                                  if (!value
                                      .contains(RegExp(r'[!@#$%^&*()]'))) {
                                    return 'Password must contain at least one special character (!@#%^&*())';
                                  }
                                  // Add any additional password validation logic here
                                  return null;
                                },
                                onChanged: (String val) {
                                  password = val;
                                },
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Mulish",
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            Container(
                              width: 290,
                              margin: const EdgeInsets.only(top: 9.1),
                              child: TextFormField(
                                controller: phoneController,
                                maxLines: 1,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFF9BC2F2),
                                  suffixIcon: Icon(
                                    Icons.phone,
                                    size: 28,
                                    color: Color(0xFF222222),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF9BC2F2),
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF9BC2F2),
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  labelText: 'Phone Number',
                                  hintText: 'Enter Your Phone Number',
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
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Mulish",
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            Container(
                              width: 290,
                              margin: const EdgeInsets.only(top: 9.1),
                              child: TextFormField(
                                controller: ageController,
                                maxLines: 1,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFF9BC2F2),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF9BC2F2),
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF9BC2F2),
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  labelText: 'Age',
                                  hintText: 'Enter Your Age',
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
                                onChanged: (String val) {
                                  age = int.parse(val);
                                },
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Mulish",
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            Container(
                              width: 290,
                              margin: const EdgeInsets.only(top: 9.1),
                              child: TextFormField(
                                controller: locationController,
                                maxLines: 1,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFF9BC2F2),
                                  suffixIcon: Icon(
                                    Icons.location_on,
                                    size: 28,
                                    color: Color(0xFF222222),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF9BC2F2),
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF9BC2F2),
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  labelText: 'Location',
                                  hintText: 'Enter Your Location',
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Location field cannot be empty';
                                  }
                                  return null;
                                },
                                onChanged: (String val) {
                                  location = val;
                                },
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Mulish",
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            Container(
                              width: 80.3.w,
                              margin: const EdgeInsets.only(top: 9.1),
                              decoration: BoxDecoration(
                                color: const Color(0xFF9BC2F2),
                                border: Border.all(
                                  color: const Color(0xFF9BC2F2),
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: TextFormField(
                                controller: genderController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFF9BC2F2),
                                  suffixIcon: Icon(
                                    Icons.person,
                                    size: 28,
                                    color: Color(0xFF222222),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF9BC2F2),
                                      width: 2,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF9BC2F2),
                                      width: 2,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  labelText: 'Select Gender',
                                  labelStyle: TextStyle(
                                    fontSize: 15.4,
                                    color: Color(0xFF222222),
                                  ),
                                  prefixIconColor: Color.fromARGB(255, 0, 0, 0),
                                ),
                                style: const TextStyle(
                                  height: 1,
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF222222),
                                  fontSize: 16.7,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                                        title: const Text('Select Gender'),
                                        content:
                                            DropdownButtonFormField<String>(
                                          value: dropdownvalue,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownvalue = newValue!;
                                              genderController.text = newValue;
                                            });
                                            Navigator.of(context).pop(newValue);
                                          },
                                          items: items.map((String item) {
                                            return DropdownMenuItem<String>(
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
                                      genderController.text = selectedGender;
                                    });
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: 290,
                              margin:
                                  const EdgeInsets.only(top: 9.1, bottom: 34),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: dobController,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFF9BC2F2),
                                      suffixIcon: Icon(
                                        Icons.calendar_month_rounded,
                                        size: 28,
                                        color: Color(0xFF222222),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF9BC2F2),
                                            width: 2,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF9BC2F2),
                                            width: 2,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      labelText: 'Date of Birth',
                                      hintText: 'Select Your Date of Birth',
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
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    onTap: () async {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      final DateTime? date =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      );
                                      if (date != null) {
                                        dobController.text =
                                            DateFormat("yyyy-MM-dd")
                                                .format(date);
                                        dob = date.toString();
                                      }
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select your date of birth';
                                      }
                                      // Add any additional validation logic for the date if needed
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        heightFactor: 0.98,
                        child: SizedBox(
                          height: 54.4,
                          width: 190,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xFF0062DE), //background color of button
                                //border width and color

                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(55)),
                              ),
                              child: const Text(
                                "Sign Up",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    height: 1.2,
                                    fontFamily: "ZenKakuGothicAntique",
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 21),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  register();
                                }
                              }),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                  height: 6.39,
                                  fontFamily: "Comfortaa",
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFDBEBC0),
                                  fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/third');
                              },
                              child: const Text(
                                "Join Now",
                                style: TextStyle(
                                    height: 5.96,
                                    fontFamily: "K2D",
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF011627),
                                    fontSize: 15.3),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(height: 1.h)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
