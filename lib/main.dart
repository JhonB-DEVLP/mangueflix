import 'package:flutter/material.dart';
import 'package:mangueflix/login/login.dart';
import 'package:mangueflix/detalhes/detalhes.dart';
import 'package:mangueflix/myseries/myseries.dart';
import 'package:mangueflix/profile/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MangueFLix',
      theme: ThemeData(
        // Utiliza o Google Fonts Karla para estilização do texto
        textTheme: GoogleFonts.karlaTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      // Rota inicial do aplicativo
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(), // Tela inicial (Login)
        '/profile': (context) => const Profile(), // Tela de Perfil
        '/detalhes': (context) => Detalhes(
            serieId: ModalRoute.of(context)?.settings.arguments as int),
        // Rotas futuras comentadas para facilitar adição posterior
        '/myseries': (context) => const MySeries(),
        // '/about': (context) => const About(),
        // '/minhaConta': (context) => const MinhaConta(),
      },
    );
  }
}
