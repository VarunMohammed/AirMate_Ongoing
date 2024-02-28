import 'package:airmate/screens/GenderSelectionScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_act/slide_to_act.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  String? firstName;
  String? middleName;
  String? lastName;

  void _navigateToGender(BuildContext context) async {
    if (firstNameController.text != '' && lastNameController.text != '') {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('firstName', firstNameController.text);
      prefs.setString('middleName', middleNameController.text);
      prefs.setString('lastName', lastNameController.text);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GenderSelectionScreen(
                  firstName: firstNameController.text,
                  middleName: middleNameController.text,
                  lastName: lastNameController.text,
                )),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text("Let's collect some details about you !",
                  style: GoogleFonts.urbanist(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  )),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                "Enter the details as in your Government ID. This will help us verify your identity.",
                style: GoogleFonts.urbanist(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey)),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Text(
                    '01',
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.bold,
                        textStyle: TextStyle(color: Colors.black)),
                  ),
                  Text(
                    '/',
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.bold,
                        textStyle: TextStyle(color: Colors.grey)),
                  ),
                  Text(
                    '03',
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.bold,
                        textStyle: TextStyle(color: Colors.grey)),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextField(
                  //onEditingComplete: () => _updateFullName(),
                  controller: firstNameController,
                  onEditingComplete: () {
                    setState(() {
                      firstName = firstNameController.text;
                    });
                  },
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: "First Name",
                    labelStyle: GoogleFonts.urbanist(
                        textStyle: const TextStyle(fontSize: 15)),
                    border: const OutlineInputBorder(),
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextField(
                  controller: middleNameController,
                  onEditingComplete: () {
                    setState(() {
                      middleName = middleNameController.text;
                    });
                  },
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: "Middle Name",
                    labelStyle: GoogleFonts.urbanist(
                        textStyle: const TextStyle(fontSize: 15)),
                    border: const OutlineInputBorder(),
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextField(
                  //onChanged: (value) => _updateFullName,
                  controller: lastNameController,
                  onEditingComplete: () {
                    setState(() {
                      lastName = lastNameController.text;
                    });
                  },
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: "Last Name",
                    labelStyle: GoogleFonts.urbanist(
                        textStyle: const TextStyle(fontSize: 15)),
                    border: const OutlineInputBorder(),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Text(
                    'First Name and Last Name are mandatory.',
                    style: GoogleFonts.urbanist(
                        textStyle: TextStyle(color: Colors.grey)),
                    textAlign: TextAlign.start,
                  ),
                  Spacer()
                ],
              ),
            ),
            SizedBox(
              height: 150,
            ),
            SlideAction(
              sliderButtonIcon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              text: 'Slide To Confirm',
              textStyle: GoogleFonts.urbanist(
                  textStyle: TextStyle(color: Colors.black54)),
              innerColor: Colors.black,
              outerColor: Colors.white,
              height: 70,
              elevation: 2,
              onSubmit: () {
                _navigateToGender(context);
                return null;
              },
            )
          ]),
        )),
      ),
    );
  }
}
