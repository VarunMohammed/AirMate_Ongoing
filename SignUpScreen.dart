import 'dart:convert';
//import 'dart:ffi';

import 'package:airmate/screens/UserDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  static const String signUpScreen = '/signUpScreen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

  Future<void> getHashValue(String password) async {
    if (fullnameController.text != '' &&
        emailIDController.text != '' &&
        passwordController.text != '' &&
        confirmPasswordController.text != '') {
      if (passwordController.text == confirmPasswordController.text) {
        final response = await http.post(
          Uri.parse('http://192.0.0.2:8080/get-hash'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'password': passwordController.text}),
        );

        if (response.statusCode == 200) {
          final hashedPassword = jsonDecode(response.body)['hashedValue'];

          final prefs = await SharedPreferences.getInstance();
          prefs.setString('hashedPassword', hashedPassword);
          prefs.setString('fullName', fullnameController.text);
          prefs.setString('emailID', emailIDController.text);
        } else {
          debugPrint('Error');
        }
      }
    }
  }

  void _continueSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => UserDetailsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                height: 41,
                                width: 41,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: Center(
                                  child: Icon(Icons.arrow_back),
                                ),
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Text('Hello! Register to get started',
                          style: GoogleFonts.urbanist(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: TextField(
                          decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: "Fullname",
                        labelStyle: GoogleFonts.urbanist(
                            textStyle: const TextStyle(fontSize: 15)),
                        border: const OutlineInputBorder(),
                      )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: TextField(
                          decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: "Email",
                        labelStyle: GoogleFonts.urbanist(
                            textStyle: const TextStyle(fontSize: 15)),
                        border: const OutlineInputBorder(),
                      )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: TextField(
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: passwordVisible
                                    ? Icon(Icons.visibility_outlined)
                                    : Icon(Icons.visibility_off_outlined),
                                onPressed: () => setState(() {
                                      passwordVisible = !passwordVisible;
                                    })),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: "Password",
                            labelStyle: GoogleFonts.urbanist(
                                textStyle: const TextStyle(fontSize: 15)),
                            border: const OutlineInputBorder(),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: TextField(
                          obscureText: !confirmPasswordVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: confirmPasswordVisible
                                    ? Icon(Icons.visibility_outlined)
                                    : Icon(Icons.visibility_off_outlined),
                                onPressed: () => setState(() {
                                      confirmPasswordVisible =
                                          !confirmPasswordVisible;
                                    })),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: "Confirm Password",
                            labelStyle: GoogleFonts.urbanist(
                                textStyle: const TextStyle(fontSize: 15)),
                            border: const OutlineInputBorder(),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          _continueSignUp();
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black),
                              //color: Colors.yellow,
                              child: Row(children: [
                                const Spacer(),
                                Text(
                                  'Register',
                                  style: GoogleFonts.urbanist(
                                      textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                ),
                                const Spacer()
                              ]),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 140,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(children: [
                        const Spacer(),
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.urbanist(
                              textStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Login Now',
                            style: GoogleFonts.urbanist(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black)),
                          ),
                        ),
                        const Spacer()
                      ]),
                    )
                  ],
                )),
          )),
    );
  }
}
