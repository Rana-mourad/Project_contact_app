import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/views/home.dart';
import 'package:project/views/login_dart.dart';
import 'package:project/views/sign_up_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      theme: ThemeData(
        textTheme: GoogleFonts.soraTextTheme(),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
      ),
      initialRoute: "/login", // Set the initial route to the login page
      routes: {
        "/home": (context) => Homepage(),
        "/signup": (context) => SignUpPage(),
        "/login": (context) => LoginPage(),
        "/add": (context) => addNewContact(),
      },
    );
  }

  addNewContact() {}
}
