import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sajilo_yatra/helpers/ui_helper.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  dynamic argumentData = Get.arguments;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _isObscured1 = true;
  String word = "";
  bool _isObscured = true;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final _storage = const FlutterSecureStorage();

  @override
  void onInit() {
    print(argumentData[0]['email']);
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: argumentData[0]['email']);
    _savedData1();
  }

  Future<void> _savedData1() async {
    final snapshot = await db
        .collection("users")
        .where("email", isEqualTo: argumentData[0]['email'])
        .get();

    final vehicleOwners = snapshot.docs.map((doc) => doc.data()).toList();

    if (vehicleOwners.isNotEmpty) {
      // check if there is at least one document in the snapshot
      final data = vehicleOwners.first;

      final pass = data['password'];

      await _storage.write(key: 'password', value: pass);

      setState(() {
        word = pass;

        _isLoading = false;
      });
    } else {
      print('No documents found for the user');
    }
  }

  void _resetPassword() async {
    final newPassword = _newPasswordController.text.trim();
    print(word);
    final current = _PasswordController.text.trim();
    if (newPassword.isNotEmpty) {
      final userDocs = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: argumentData[0]['email'])
          .get();
      if (userDocs.docs.isNotEmpty) {
        final userDoc = userDocs.docs.first;

        if (current == word) {
          try {
            await userDoc.reference.update({"password": newPassword});
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: 'Password updated successfully!',
              confirmBtnColor: const Color(0xFF0062DE),
              onConfirmBtnTap: () {
                Get.toNamed('/third');
              },
            );
            print("Password updated successfully in Firestore");
          } catch (e) {
            Get.snackbar(
              "Error",
              "Error updating password in Firestore",
              backgroundColor: Colors.red.shade400,
              colorText: Colors.grey.shade900,
              duration: const Duration(milliseconds: 3000),
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(10),
              borderRadius: 10,
              borderWidth: 2,
              borderColor: Colors.red,
              animationDuration: const Duration(milliseconds: 400),
            );
            print("Error updating password in Firestore: $e");
          }
        } else {
          Get.snackbar(
            "Error",
            "Current password does not match",
            backgroundColor: Colors.red.shade400,
            colorText: Colors.grey.shade900,
            duration: const Duration(milliseconds: 3000),
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(10),
            borderRadius: 10,
            borderWidth: 2,
            borderColor: Colors.red,
            animationDuration: const Duration(milliseconds: 400),
          );
          print("Current password does not match");
        }
      } else {
        Get.snackbar(
          "Error",
          "No user found with email ${argumentData[0]['email']} in Firestore",
          backgroundColor: Colors.red.shade400,
          colorText: Colors.grey.shade900,
          duration: const Duration(milliseconds: 3000),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          borderWidth: 2,
          borderColor: Colors.red,
          animationDuration: const Duration(milliseconds: 400),
        );
        print(
            "No user found with email ${argumentData[0]['email']} in Firestore");
      }
    }
  }

  final _PasswordController = TextEditingController();

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
                Get.back(result: [
                  {"backValue": "one"}
                ]);
              },
            );
          },
        ),
        backgroundColor: const Color(0xFF0062DE),
        title: Text('Change Password',
            style: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontFamily: 'ComicNeue',
              fontSize: UiHelper.displayWidth(context) * 0.055,
              fontWeight: FontWeight.w900,
            )),
      ),
      body: _isLoading
          ? Container(
              child: LoadingAnimationWidget.hexagonDots(
                size: UiHelper.displayWidth(context) * 0.08,
                color: const Color(0xFF0062DE),
              ),
            )
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
                                } else if (!value.endsWith('@gmail.com') &&
                                    !value.endsWith('@sajiloyatra.com.np')) {
                                  return 'Email address must end with "@gmail.com", or "@sajiloyatra.com.np"';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: UiHelper.displayWidth(context) * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              controller: _PasswordController,
                              obscureText: _isObscured,
                              maxLines: 1,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscured
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: const Color(0xFF271C24),
                                      size: UiHelper.displayHeight(context) *
                                          0.028,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscured = !_isObscured;
                                      });
                                    }),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFA6AEB0),
                                      width: 2,
                                      style: BorderStyle.solid),
                                ),
                                labelText: 'Current Password',
                                hintText: 'Enter Your Current Password',
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Current Password field cannot be empty';
                                }
                                if (value.length < 6) {
                                  return 'Current Password must be at least 6 characters long';
                                }
                                if (!value.contains(RegExp(r'[A-Z]'))) {
                                  return 'Current Password must contain at least one uppercase letter';
                                }
                                if (!value.contains(RegExp(r'[0-9]'))) {
                                  return 'Current Password must contain at least one digit';
                                }
                                if (!value.contains(RegExp(r'[!@#$%^&*()]'))) {
                                  return 'Current Password must contain at least one special character (!@#%^&*())';
                                }
                                // Add any additional password validation logic here
                                return null;
                              },
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
                          width: UiHelper.displayWidth(context) * 0.8,
                          margin: const EdgeInsets.only(bottom: 28.5),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              controller: _newPasswordController,
                              obscureText: _isObscured1,
                              maxLines: 1,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscured1
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: const Color(0xFF271C24),
                                      size: UiHelper.displayHeight(context) *
                                          0.028,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscured1 = !_isObscured1;
                                      });
                                    }),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFA6AEB0),
                                      width: 2,
                                      style: BorderStyle.solid),
                                ),
                                labelText: 'New Password',
                                hintText: 'Enter Your New Password',
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'New Password field cannot be empty';
                                }
                                if (value.length < 6) {
                                  return 'New Password must be at least 6 characters long';
                                }
                                if (!value.contains(RegExp(r'[A-Z]'))) {
                                  return 'New Password must contain at least one uppercase letter';
                                }
                                if (!value.contains(RegExp(r'[0-9]'))) {
                                  return 'New Password must contain at least one digit';
                                }
                                if (!value.contains(RegExp(r'[!@#$%^&*()]'))) {
                                  return 'New Password must contain at least one special character (!@#%^&*())';
                                }
                                // Add any additional password validation logic here
                                return null;
                              },
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
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: SizedBox(
                            height: UiHelper.displayHeight(context) * 0.069,
                            width: UiHelper.displayWidth(context) * 0.1,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xFF0062DE), //background color of button
                                //border width and color

                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _resetPassword();
                                }
                              },
                              child: Text(
                                "Reset Password",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  height:
                                      UiHelper.displayHeight(context) * 0.001,
                                  fontFamily: "ZenKakuGothicAntique",
                                  fontWeight: FontWeight.w600,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize:
                                      UiHelper.displayWidth(context) * 0.048,
                                ),
                              ),
                            ),
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
}
