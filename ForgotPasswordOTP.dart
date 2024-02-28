import 'package:airmate/screens/HomeScreen.dart';
import 'package:airmate/screens/passwordChange.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class ForgotPasswordOTP extends StatefulWidget {
  static const String otpScreen = '/otpScreen';
  final String emailID;
  const ForgotPasswordOTP({super.key, required this.emailID});

  @override
  State<ForgotPasswordOTP> createState() => _ForgotPasswordOTPState();
}

class _ForgotPasswordOTPState extends State<ForgotPasswordOTP> {
  TextEditingController otpController = TextEditingController();

  void _navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _navigateToPasswordChange() {
    if (otpController.text == "12345") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PasswordChangeScreen(
                  emailID: widget.emailID,
                )),
      );
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
                                  const BorderRadius.all(Radius.circular(12))),
                          child: const Center(
                            child: Icon(Icons.arrow_back),
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 28,
                ),
                Row(
                  children: [
                    Text(
                      'OTP Verification',
                      style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    const Spacer()
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Enter the verification code we just sent on your email address: ${widget.emailID}',
                  style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey)),
                ),
                const SizedBox(
                  height: 38,
                ),
                Pinput(
                  length: 5,
                  hapticFeedbackType: HapticFeedbackType.heavyImpact,
                  keyboardType: TextInputType.number,
                  defaultPinTheme: PinTheme(
                    width: 70,
                    height: 60,
                    textStyle: const TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(234, 239, 243, 1)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 70,
                    height: 60,
                    textStyle: const TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  errorPinTheme: PinTheme(
                    width: 70,
                    height: 60,
                    textStyle: const TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  submittedPinTheme: PinTheme(
                    width: 70,
                    height: 60,
                    textStyle: const TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  controller: otpController,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) {
                    _navigateToPasswordChange();
                  },
                ),
                const SizedBox(
                  height: 480,
                ),
                Row(children: [
                  const Spacer(),
                  Text(
                    "Didn't receive code?",
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
                      //Navigator.pop(context);
                    },
                    child: Text(
                      'Resend',
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
          ),
        ),
      ),
    );
  }
}
