import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Cor de fundo
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: IconButton(
            icon: Image.asset('assets/image/mangueFlix.png'),
            iconSize: 50,
            onPressed: () {},
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.red),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Configurações",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 25), // Espaçamento
            _buildButton(context, "Conta"),
            const SizedBox(height: 25),
            _buildButton(context, "Tema"),
            const SizedBox(height: 25),
            _buildButton(context, "Privacidade"),
            const SizedBox(height: 25),
            _buildButton(context, "Idioma"),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text) {
    return ElevatedButton(
      onPressed: () {
        // Adicione a funcionalidade aqui
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF691C3A), // Cor de fundo
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white, // Cor do texto
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white), // Ícone de seta
        ],
      ),
    );
  }
}
