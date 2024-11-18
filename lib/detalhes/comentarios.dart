import 'package:flutter/material.dart';
import 'package:mangueflix/colors/colors.dart';

class Comentarios extends StatelessWidget {
  const Comentarios({Key? key}) : super(key: key);

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
        SizedBox(height: 8),
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
    Key? key,
    required this.username,
    required this.comment,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          username,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: vinho,
          ),
        ),
        Row(
          children: List.generate(
            rating,
            (index) => const Icon(Icons.star, color: vermelho, size: 16),
          ),
        ),
        Text(
          comment,
          style: const TextStyle(color: vinho),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
