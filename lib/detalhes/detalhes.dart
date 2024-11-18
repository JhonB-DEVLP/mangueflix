import 'package:flutter/material.dart';
import 'package:mangueflix/colors/colors.dart';
import 'infoSerie.dart';
import 'comentarios.dart';

class Detalhes extends StatelessWidget {
  const Detalhes({Key? key}) : super(key: key);

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
              backgroundImage: AssetImage('assets/image/fotoFlutter.png'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              InfoSerie(), 
              Divider(color: vermelho),
              Comentarios(), 
            ],
          ),
        ),
      ),
    );
  }
}