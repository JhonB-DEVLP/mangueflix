import 'package:flutter/material.dart';
import 'package:mangueflix/colors/colors.dart';

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
        )),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: const Icon(Icons.arrow_back, color: Colors.red)),
      ),
      body: Column(
        children: [
          Card(
            elevation: 0,
            color: Colors.transparent,
            child: ListTile(
              leading: Image.asset('assets/image/fotoFlutter.png'),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Gabriel Henrique",
                    style: TextStyle(
                      color: titulo,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
