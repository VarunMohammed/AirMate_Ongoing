import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      'Welcome',
                      style: GoogleFonts.urbanist(
                          textStyle: TextStyle(color: Colors.grey)),
                    )
                  ],
                )
              ]),
            )),
      ),
    );
  }
}
