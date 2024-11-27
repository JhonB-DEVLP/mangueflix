import 'package:flutter/material.dart';
import 'package:mangueflix/colors/colors.dart';
import 'info_serie.dart';
import 'comentarios.dart';

class Detalhes extends StatelessWidget {
  final int serieId; // ID da série passado ao componente InfoSerie

  const Detalhes({super.key, required this.serieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: vermelho),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: const AssetImage('assets/image/fotoFlutter.png'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoSerie(serieId: serieId), // Passa o ID da série
              const Divider(color: vermelho, thickness: 2),
              const Comentarios(),
            ],
          ),
        ),
      ),
    );
  }
}
