import 'package:flutter/material.dart';
import 'package:mangueflix/myDrawer.dart';
import 'package:mangueflix/colors/colors.dart';
import 'package:mangueflix/profile/profile.dart';
import 'home/homePage.dart'; // Supondo que a página Home esteja no arquivo home.dart

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: IconButton(
            icon: Image.asset('assets/image/mangueFlix.png'),
            iconSize: 50,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AppBody()),
              );
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/image/fotoFlutter.png'),
            iconSize: 50,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ),
              );
            },
          )
        ],
      ),
      body: const Home(), // Chamando a página Home no body
    );
  }
}
