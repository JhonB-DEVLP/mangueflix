import 'package:flutter/material.dart';
import 'package:mangueflix/colors/colors.dart';
import 'package:mangueflix/my_drawer.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo, // Cor de fundo do tema
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Sem sombra
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: vermelho),
          onPressed: () {
            Navigator.pop(context); // Volta para a página anterior
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Center(
                child: Image.asset('assets/image/MangueFlixLogin.png'),
              ),
              const SizedBox(height: 10),
              
              const SizedBox(height: 20),
              // Título "O que é o MangueFlix?"
              const Text(
                'O que é o MangueFlix?',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE40624),
                ),
              ),
              const SizedBox(height: 10),
              // Texto descritivo
              const Text(
                'O MangueFlix é um aplicativo inovador que combina entretenimento e interatividade, permitindo que você avalie suas séries e filmes favoritos. Inspirado pela criatividade e cultura local, o MangueFlix oferece uma plataforma onde os usuários podem compartilhar suas opiniões, descobrir novas recomendações e explorar conteúdos baseados em avaliações da comunidade. Seja para dar sua nota para aquela série que marcou ou para encontrar um filme perfeito para a próxima sessão de cinema, o MangueFlix é o lugar certo para os apaixonados por histórias.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 30),
              // Rodapé
              const Text(
                '© 2024. Todos os direitos reservados',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF691C3A),
                ),
              ),
            ],
          ),
        ),
      ),
      // Adicionando o BottomNavBar global
      
    );
  }
}
