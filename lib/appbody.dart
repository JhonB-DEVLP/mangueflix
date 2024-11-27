import 'package:flutter/material.dart';
import 'package:mangueflix/myDrawer.dart';
import 'package:mangueflix/colors/colors.dart';
import './customappbar.dart';
import 'package:mangueflix/home/homePage.dart';

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
      drawer: const MyDrawer(), // Drawer permanece apenas na página inicial
      appBar: const CustomAppBar(showBackButton: false, actions: [],), // Usa o CustomAppBar sem o botão de voltar
      body: const Home(), // Página inicial (Home)
    );
  }
}
