import 'package:flutter/material.dart';
import 'package:mangueflix/colors/colors.dart';

class InfoSerie extends StatelessWidget {
  const InfoSerie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto no topo da imagem
          children: [
            Image.asset(
              'assets/image/peakyblinders.jpg',
              height: 30,  
              width: 35,   
            ),
            const SizedBox(width: 16), // Espaço entre a imagem e os textos

            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto à esquerda
              children: [
                const Text(
                  'The Peaky Blinders',
                  style: TextStyle(
                    fontSize: 24,  
                    fontWeight: FontWeight.bold,
                    color: vinho,
                  ),
                ),
                const SizedBox(height: 8), 
                const Text(
                  'Uma notória gangue da Inglaterra de 1909 ascende no submundo liderada pelo cruel Tommy Shelby, um criminoso disposto a subir na vida a qualquer preço.',
                  style: TextStyle(fontSize: 16, color: vinho),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16), 
        const Text(
          'Detalhes',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: vinho,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Classificação: +18\n'
          'Gênero: Histórico, Drama, Crime, Suspense, Mistério\n'
          'Criadores: Steven Knight, etc...',
          style: TextStyle(fontSize: 16, color: vinho),
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            const Text(
              'Estrelas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: vinho),
            ),
            const SizedBox(width: 8),
            ...List.generate(
              4,
              (index) => const Icon(Icons.star, color: vermelho),
            ),
            const Icon(Icons.star_border, color: vermelho),
            const SizedBox(width: 8),
            const Text(
              '4.0',
              style: TextStyle(fontSize: 18, color: vermelho),
            ),
          ],
        ),
      ],
    );
  }
}
