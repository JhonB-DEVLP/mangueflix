import 'package:flutter/material.dart';
import 'package:mangueflix/colors/colors.dart';

class Comentarios extends StatelessWidget {
  const Comentarios({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Comentários',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: vinho,
          ),
        ),
        SizedBox(height: 16),
        ComentarioWidget(
          username: 'Fábio Maciel',
          comment:
              'A série é fascinante, cheia de reviravoltas. A atuação de Cillian Murphy é impecável.',
          rating: 5,
        ),
        ComentarioWidget(
          username: 'Janete Silva',
          comment: 'Achei um pouco lento no início, mas depois melhora!',
          rating: 4,
        ),
      ],
    );
  }
}

class ComentarioWidget extends StatelessWidget {
  final String username;
  final String comment;
  final int rating;

  const ComentarioWidget({
    super.key,
    required this.username,
    required this.comment,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      color: const Color(0xFFF5F5F5),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: vinho,
              ),
            ),
            Row(
              children: List.generate(
                rating,
                (index) => const Icon(Icons.star, color: vermelho, size: 16),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              comment,
              style: const TextStyle(fontSize: 14, color: vinho),
            ),
          ],
        ),
      ),
    );
  }
}
