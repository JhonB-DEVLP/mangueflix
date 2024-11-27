import 'package:flutter/material.dart';
import 'package:mangueflix/colors/colors.dart';
import 'package:mangueflix/profile/bio.dart';
import 'package:mangueflix/profile/histAval.dart';
import 'package:mangueflix/profile/infos.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: IconButton(
            style: const ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll<Color>(Color(0x00000000))),
            icon: Image.asset('assets/image/mangueFlix.png'),
            iconSize: 50,
            onPressed: () {},
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: const Icon(Icons.arrow_back, color: Colors.red),
        ),
      ),
      body: ListView(
        children: const [
          Infos(),
          Padding(
            padding: EdgeInsets.only(
              top: 30,
              bottom: 30,
            ),
          ),
          Bio(),
          HistAval(),
        ],
      ),
      
    );
  }
}
