import 'package:airmate/screens/AuthenticationScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordChangeSuccessScreen extends StatelessWidget {
  const PasswordChangeSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Image.asset('assets/images/successicon.png'),
            SizedBox(
              height: 35,
            ),
            Text('Password Changed!',
                style: GoogleFonts.urbanist(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 8,
            ),
            Text(
              'Your password has been changed\nsuccessfully.',
              style: GoogleFonts.urbanist(
                  textStyle: TextStyle(
                      color: const Color.fromARGB(255, 128, 128, 128),
                      fontSize: 15,
                      fontWeight: FontWeight.w300)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AuthenticationScreen()),
                  (route) => false, // Remove all routes in the stack
                );
              },
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black),
                    //color: Colors.yellow,
                    child: Row(children: [
                      const Spacer(),
                      Text(
                        'Back to Login',
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
            Spacer()
          ],
        ),
      ),
    );
  }
}
