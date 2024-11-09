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
              padding: EdgeInsets.all(25),
              child: const TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffffffff),
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.red,
                      width: 1.5,
                    )),
                    hintText: 'Search for movies',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2.5,
                      ),
                    )),
              ))),
    );
  }
}
