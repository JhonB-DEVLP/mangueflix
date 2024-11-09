import 'package:flutter/material.dart';
import 'package:mangueflix/login/login.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.karlaTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        //'/profile': (context) => const Profile(),
        //'/minhaConta': (context) => const MinhaConta()
      },
    );
  }
}
