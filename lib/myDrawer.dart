import 'package:flutter/material.dart';
import 'package:mangueflix/colors/colors.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: fundo,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 0.1,
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.report),
              title: const Text("Reportar Problema"),
              onTap: () {
                print("Problema Reportado");
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 0.1,
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.brightness_7),
              title: const Text("Configurações"),
              onTap: () {
                print("Configurações");
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 0.1,
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text("Sobre o App"),
              onTap: () {
                print("O app foi feito pelo grupo mais foda da história");
              },
            ),
          ),
          const Spacer(), // Adiciona espaço flexível para empurrar o botão "Sair" para o fundo
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 0.5),
            ),
            padding: const EdgeInsets.all(15),
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
                size: 30,
              ),
              title: const Text(
                "Sair",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Fecha o Drawer
                Navigator.pop(context); // Fecha a tela atual
              },
            ),
          ),
        ],
      ),
    );
  }
}
