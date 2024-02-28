import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';

class GenderSelectionScreen extends StatefulWidget {
  final firstName;
  final middleName;
  final lastName;

  const GenderSelectionScreen(
      {super.key, required this.firstName, this.middleName, this.lastName});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  double containerWidth = 140;
  double containerHeight = 140;

  String? gender;
  bool maleSelected = false;
  bool femaleSelected = false;
  bool othersSelected = false;

  Icon? sliderIcon = Icon(
    Icons.arrow_forward_ios,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Text("Welcome!",
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        )),
                    Spacer()
                  ],
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text(
                        '${widget.middleName != '' ? widget.firstName + ' ' + widget.middleName + ' ' + widget.lastName : widget.firstName + ' ' + widget.lastName}',
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        )),
                    Spacer()
                  ],
                )),
            SizedBox(
              height: 15,
            ),
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
                    '02',
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
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                      child: Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Male',
                          style: GoogleFonts.urbanist(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        SizedBox(
                          width: 202,
                        ),
                        Icon(
                          Icons.male,
                          color: maleSelected ? Colors.black : Colors.grey,
                          size: 40,
                        ),
                      ]),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                              color: maleSelected ? Colors.black : Colors.grey,
                              width: 2)),
                      //width: 105,
                      height: 75,
                      //color: Colors.black,
                    ),
                    onTap: () {
                      setState(() {
                        gender = 'Male';
                        sliderIcon = Icon(
                          Icons.male,
                          color: Colors.white,
                        );
                        maleSelected = !maleSelected;
                        if (femaleSelected) {
                          femaleSelected = false;
                        }
                        if (othersSelected) {
                          othersSelected = false;
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    child: Container(
                      child: Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Female',
                          style: GoogleFonts.urbanist(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        SizedBox(
                          width: 180,
                        ),
                        Icon(
                          Icons.female,
                          color: femaleSelected ? Colors.black : Colors.grey,
                          size: 40,
                        ),
                      ]),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                              color:
                                  femaleSelected ? Colors.black : Colors.grey,
                              width: 2)),
                      //width: 105,
                      height: 75,
                      //color: Colors.black,
                    ),
                    onTap: () {
                      setState(() {
                        gender = 'Female';
                        sliderIcon = Icon(
                          Icons.female,
                          color: Colors.white,
                        );
                        femaleSelected = !femaleSelected;
                        if (maleSelected) {
                          maleSelected = false;
                        }
                        if (othersSelected) {
                          othersSelected = false;
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    child: Container(
                      child: Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Others',
                          style: GoogleFonts.urbanist(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        SizedBox(
                          width: 185,
                        ),
                        Icon(
                          Icons.transgender,
                          color: othersSelected ? Colors.black : Colors.grey,
                          size: 35,
                        ),
                      ]),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                              color:
                                  othersSelected ? Colors.black : Colors.grey,
                              width: 2)),
                      //width: 105,
                      height: 75,
                      //color: Colors.black,
                    ),
                    onTap: () {
                      setState(() {
                        gender = 'Others';
                        othersSelected = !othersSelected;
                        sliderIcon = Icon(
                          Icons.transgender,
                          color: Colors.white,
                        );
                        if (femaleSelected) {
                          femaleSelected = false;
                        }
                        if (maleSelected) {
                          maleSelected = false;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 150,
            ),
            SlideAction(
              sliderButtonIcon: sliderIcon,
              text: 'Slide To Confirm',
              textStyle: GoogleFonts.urbanist(
                  textStyle: TextStyle(color: Colors.black54)),
              innerColor: Colors.black,
              outerColor: Colors.white,
              height: 70,
              elevation: 2,
              onSubmit: () {
                //_navigateToGender(context);
                return null;
              },
            )
          ]),
        )),
      ),
    );
  }
}
