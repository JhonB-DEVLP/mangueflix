import 'package:flutter/material.dart';
import 'package:mangueflix/colors/colors.dart';

class Bio extends StatelessWidget {
  const Bio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 0,
              color: Colors.transparent,
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Bio",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: vinho),
                    ),
                    IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                  ],
                ),
                subtitle: const Text(
                  "Sou Gabriel, tenho 20 anos e sou apaixonado por cinema, adoro avaliar filmes e compartilhar minhas opiniões com amigos e online. No meu tempo livre, gosto de sair e me divertir com outros rapazes, aproveitando para conhecer pessoas e viver novas experiências. Criativo e descontraído, estou sempre em busca de boas conversas e aventuras.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]),
    );
  }
}
