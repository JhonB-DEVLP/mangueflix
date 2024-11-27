import 'package:flutter/material.dart';
import 'package:mangueflix/login/login.dart';
import 'package:mangueflix/detalhes/detalhes.dart';
import 'package:mangueflix/myseries/myseries.dart';
import 'package:mangueflix/profile/profile.dart';
import 'package:mangueflix/about/about.dart';
import 'package:mangueflix/report/report.dart';
import 'package:mangueflix/home/homePage.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MangueFLix',
      theme: ThemeData(
        // Configura fonte local 'Karla' definida no pubspec.yaml
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Karla'),
          bodyMedium: TextStyle(fontFamily: 'Karla'),
          bodySmall: TextStyle(fontFamily: 'Karla'),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/profile': (context) => const Profile(),
        '/homePage': (context) => const Home(),
        '/detalhes': (context) => Detalhes(
            serieId: ModalRoute.of(context)?.settings.arguments as int),
        '/myseries': (context) => const MySeries(),
        '/about': (context) => const About(),
        '/report': (context) => const Report(),
      },
    );
  }
}
