import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:sajilo_yatra/users/userhome.dart';

import 'forgotpassword.dart';

class FifthScreen extends StatefulWidget {
  const FifthScreen({Key? key}) : super(key: key);
  @override
  State<FifthScreen> createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  var size, height, width;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  bool _isObscure = true;
  bool _rememberMe = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? email;
  String? password;
  final _formKey = GlobalKey<FormState>();
  Color originalButtonColor = const Color(0xFF0062DE);
  Color? _buttonColor;
  final storage = const FlutterSecureStorage();

  void _onRememberMeChanged(bool? newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = newValue ?? false;
      if (_rememberMe) {
        prefs.setString('email', emailController.text);
        prefs.setString('password', passwordController.text);
      } else {
        prefs.remove('email');
        prefs.remove('password');
      }
    });
  }

  void _loadSavedLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email != null && password != null) {
      emailController.text = email;
      passwordController.text = password;
      setState(() {
        _rememberMe = true;
      });
    }
  }

  Future<void> login() async {
    setState(() {
      email = emailController.text;
      password = passwordController.text;
    });

    if (_rememberMe) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email!);
      prefs.setString('password', password!);
    }

    final snapshot = await db.collection("users").get();
    final users = snapshot.docs
        .map((doc) => doc.data())
        .where(
            (owner) => owner["email"] == email && owner["password"] == password)
        .toList();

    if (users.length == 1) {
      final user = users.first;
      final fullName = user["full_name"];
      final location = user["location"];
      final email = user["email"];
      final password = user["password"];
      final phoneNumber = user["phone_number"];
      final gender = user["gender"];
      final age = user["age"];
      final dob = user["dob"].toString();

      await storage.write(key: 'full_name', value: fullName);
      await storage.write(key: 'location', value: location);
      await storage.write(key: 'email', value: email);
      await storage.write(key: 'phone_number', value: phoneNumber.toString());
      await storage.write(key: 'gender', value: gender);
      await storage.write(key: 'age', value: age.toString());
      await storage.write(key: 'dob', value: dob);
      await storage.write(key: 'password', value: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Get.toNamed('/hun1');
    } else {
      Get.snackbar(
        "Error",
        "Invalid Email and Password!",
        backgroundColor: Colors.red.shade400,
        colorText: Colors.grey.shade900,
        duration: const Duration(milliseconds: 2000),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        borderWidth: 2,
        borderColor: Colors.red,
        animationDuration: const Duration(milliseconds: 400),
      );
    }
  }

  Future<void> storeToken(String token) async {
    final expirationDate = DateTime.now().add(const Duration(days: 30));
    await storage.write(key: 'token', value: token);
    await storage.write(
        key: 'tokenExpiration', value: expirationDate.toIso8601String());
  }

  Future<String?> retrieveToken() async {
    final tokenExpirationString = await storage.read(key: 'tokenExpiration');
    if (tokenExpirationString != null) {
      final tokenExpiration = DateTime.parse(tokenExpirationString);
      if (tokenExpiration.isAfter(DateTime.now())) {
        final token = await storage.read(key: 'token');
        return token;
      } else {
        await storage.delete(key: 'token');
        await storage.delete(key: 'tokenExpiration');
        return null;
      }
    } else {
      final token = await storage.read(key: 'token');
      return token;
    }
  }

  @override
  void initState() {
    super.initState();

    _loadSavedLoginDetails();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
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
                          height: 9.h,
                        ),
                        Image.asset(
                          "images/logos.png",
                          width: 227,
                          height: 220,
                          fit: BoxFit.fill,
                        ),
                        const Align(
                          alignment: Alignment.bottomCenter,
                          heightFactor: 0.0001,
                          child: Text(
                            "Sign In to continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                height: 0.8,
                                letterSpacing: 0.3,
                                fontFamily: "KumbhSans",
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFFFFF),
                                fontSize: 26),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 37),
                          child: Column(
                            children: [
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
                                        !value
                                            .endsWith('@sajiloyatra.com.np')) {
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
                                margin:
                                    const EdgeInsets.only(bottom: 18, top: 8.5),
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
                            ],
                          ),
                        ),
                        Container(
                          width: width * 0.49,
                          height: height * 0.04,
                          margin: const EdgeInsets.only(right: 122, bottom: 35),
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: const Color(0xFFFFFFFF),
                                activeColor: const Color(0xFF0062DE),
                                value: _rememberMe,
                                onChanged: _onRememberMeChanged,
                              ),
                              Text(
                                'Remember me',
                                style: TextStyle(
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff2222222),
                                  fontSize: width * 0.042,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          heightFactor: 0.9,
                          child: Container(
                            height: 54.4,
                            width: 190,
                            margin: const EdgeInsets.only(bottom: 4),
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
                                "Sign In",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    height: 1.2,
                                    fontFamily: "ZenKakuGothicAntique",
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 21),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  login();
                                }
                              },
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const ForgotPasswordScreen(),
                                    arguments: [
                                  {'email': emailController.text},
                                ])!
                                .then((result) {
                              if (result[0]["backValue"] == "one") {
                                print("Result is coming");
                              }
                            });
                          },
                          child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "Change Password?",
                              style: TextStyle(
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF222222),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 0),
                          child: Row(
                            children: [
                              const Align(
                                alignment: Alignment.bottomRight,
                                widthFactor: 1.38,
                                heightFactor: 0.9,
                                child: Text(
                                  "Don't have any account?",
                                  style: TextStyle(
                                      height: 5.5,
                                      fontFamily: "Comfortaa",
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 14),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/fifth');
                                },
                                child: const Align(
                                  alignment: Alignment.bottomRight,
                                  widthFactor: 1.13,
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        height: 4.05,
                                        fontFamily: "K2D",
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF222222),
                                        fontSize: 15.3),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
