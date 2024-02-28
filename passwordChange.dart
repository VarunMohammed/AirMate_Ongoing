import 'package:airmate/screens/PasswordChangeSuccessScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class PasswordChangeScreen extends StatefulWidget {
  final String emailID;
  const PasswordChangeScreen({super.key, required this.emailID});

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> updatePassword(String newPassword) async {
    final url = Uri.parse('https://192.0.0.2:8080/update-password');
    final username = widget.emailID;
    final response = await http
        .post(url, body: {'username': username, 'newPassword': newPassword});

    if (response.statusCode == 200) {
      //Navigate to success Screen
    } else {
      //Stay here
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
                    'Create new password',
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
                "Your password must be unique from those previously used. \n\n${widget.emailID}",
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
                  //controller: emailIDController,
                  decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: "New Password",
                labelStyle: GoogleFonts.urbanist(
                    textStyle: const TextStyle(fontSize: 15)),
                border: const OutlineInputBorder(),
              )),
              const SizedBox(height: 15),
              TextField(
                  //controller: emailIDController,
                  decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: "Confirm Password",
                labelStyle: GoogleFonts.urbanist(
                    textStyle: const TextStyle(fontSize: 15)),
                border: const OutlineInputBorder(),
              )),
              const SizedBox(height: 35),
              GestureDetector(
                onTap: () {
                  if (passwordController.text ==
                      confirmPasswordController.text) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordChangeSuccessScreen()),
                    );
                    //updatePassword(passwordController.text);
                  } else {
                    //Passwords do not match
                  }
                  //fetchData(context, emailIDController.text);
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
                          'Reset Password',
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
            ],
          ),
        )),
      ),
    );
  }
}
