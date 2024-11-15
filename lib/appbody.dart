import 'package:flutter/material.dart';
import 'package:mangueflix/myDrawer.dart';
import 'package:mangueflix/colors/colors.dart';
import 'package:mangueflix/profile/profile.dart';

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
            child: IconButton(
          style: const ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll<Color>(Color(0x00000000))),
          icon: Image.asset('assets/image/mangueFlix.png'),
          iconSize: 50,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AppBody()),
            );
          },
        )),
        actions: [
          IconButton(
            style: const ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll<Color>(Color(0x00000000))),
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
      body: Center(
          child: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(40),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: const Color(0xffffffff),
                    prefixIcon: const Icon(
                        Icons.search,
                        color: vermelho, 
                      ),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: vermelho,
                      width: 1.5,
                    )),
                    hintText: 'Pesquise Séries',
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: vermelho,
                        width: 2.5,
                      ),
                    )),
              ))),
    );
  }
}
