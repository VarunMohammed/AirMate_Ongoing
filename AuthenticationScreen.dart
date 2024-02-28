import 'dart:convert';
import 'package:airmate/screens/ForgotPassword.dart';
import 'package:airmate/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:bloc/bloc.dart';
import 'SignUpScreen.dart';
import 'package:http/http.dart' as http;

class AuthenticationScreen extends StatefulWidget {
  static const String authenticationScreen = '/authenticationScreen';
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;

  Future<void> loginUser(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://192.0.0.2:8080/login'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'username': usernameController.text,
        'password': passwordController.text
      }),
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      print('Failed to login: ${response.body}');
    }
  }

  void _navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  void _navigateToForgotPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPassword()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AirMAte',
        home: Scaffold(
          extendBodyBehindAppBar: true,
          //resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white, //Colors.white70,
          body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/yellowAuth.jpg',
                          //scale: 8.0,
                          fit: BoxFit.fill,
                          height: 225,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //Image.asset(
                        //  'assets/images/airmate_dark.png',
                        //  scale: 3.5,
                        //),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Text('Welcome Back! Glad to see you, Again!',
                              style: GoogleFonts.urbanist(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              )),
                        ),

                        const SizedBox(
                          height: 25,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: TextField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                labelText: "Enter your email",
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
                              controller: passwordController,
                              obscureText: !passwordVisible,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                ),
                                suffixIconColor: Colors.grey,
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                labelText: "Enter your Password",
                                labelStyle: GoogleFonts.urbanist(
                                    textStyle: const TextStyle(fontSize: 15)),
                                border: const OutlineInputBorder(),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  _navigateToForgotPassword(context);
                                },
                                child: Text('Forgot Password?',
                                    style: GoogleFonts.urbanist(
                                        textStyle: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 62, 62, 62),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600))),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              HapticFeedback.vibrate();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
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
                                      'Login',
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
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 112,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: Color(0xFFE8ECF4),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Or Login with',
                                style: GoogleFonts.urbanist(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                width: 112,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: Color(0xFFE8ECF4),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              //_readNfcTag();
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black54),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  //color: Colors.yellow,
                                  child: Row(children: [
                                    const Spacer(),
                                    Text(
                                      'NFC card',
                                      style: GoogleFonts.urbanist(
                                          textStyle: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.nfc,
                                      color: Colors.black,
                                    ),
                                    const Spacer()
                                  ]),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(children: [
                            const Spacer(),
                            Text(
                              "Don't have an account?",
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
                                _navigateToSignUp(context);
                              },
                              child: Text(
                                'Register Now',
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
        ));
  }
}
