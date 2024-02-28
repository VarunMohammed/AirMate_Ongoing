//import 'dart:convert';

import 'package:airmate/screens/ForgotPasswordOTP.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
//import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailIDController = TextEditingController();

  void _navigateToOTP(BuildContext context, String email) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ForgotPasswordOTP(
                emailID: email,
              )),
    );
  }

  Future<void> sendCode(BuildContext context, String emailId) async {
    final String apiUrl = 'http://192.0.0.2:8080/forgot?email=$emailId';

    try {
      final response = await http.post(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Successful API call
        print('API Response: ${response.body}');

        //final otp = jsonDecode(response.body)['userOTP'];
        //final prefs = await SharedPreferences.getInstance();
        //prefs.setString("UserOTP", otp);

        // Pass email as an argument to ForgotPasswordOTP
        _navigateToOTP(context, emailIDController.text);
      } else {
        // Handle error
        print('Error - Status Code: ${response.statusCode}');
        print('Error - Body: ${response.body}');
      }
    } catch (error) {
      // Handle network or unexpected errors
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
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
                      ))
                ],
              ),
              SizedBox(
                height: 28,
              ),
              //Title and subtitle
              Row(
                children: [
                  Text(
                    'Forgot Password?',
                    style: GoogleFonts.urbanist(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Spacer()
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Don't worry! It occurs. Please enter the email address linked with your account.",
                style: GoogleFonts.urbanist(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey)),
              ),
              const SizedBox(
                height: 35,
              ),
              //Mail ID entry
              TextField(
                  controller: emailIDController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: "Enter your email",
                    labelStyle: GoogleFonts.urbanist(
                        textStyle: const TextStyle(fontSize: 15)),
                    border: const OutlineInputBorder(),
                  )),
              const SizedBox(height: 35),
              GestureDetector(
                onTap: () {
                  sendCode(context, emailIDController.text);
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
                          'Send Code',
                          style: GoogleFonts.urbanist(
                              textStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.yellow)),
                        ),
                        const Spacer()
                      ]),
                    )),
              ),
              SizedBox(
                height: 400,
              ),
              Row(children: [
                const Spacer(),
                Text(
                  "Remember Password?",
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
                    'Login',
                    style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black)),
                  ),
                ),
                const Spacer()
              ])
            ],
          ),
        )),
      ),
    );
  }
}
