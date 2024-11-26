import 'package:flutter/material.dart';
import 'package:mangueflix/colors/colors.dart'; // Certifique-se de que a cor "vinho" esteja definida.

class HistAval extends StatelessWidget {
  const HistAval({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  "Histórico de Avaliações",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: vinho, // Use a mesma cor da Bio.
                  ),
                ),
                // Removido o IconButton
              ],
            ),
            subtitle: const Text(
              "Aqui aparecerá o histórico de avaliações realizadas.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}