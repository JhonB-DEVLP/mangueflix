import 'package:flutter/material.dart';

class Report extends StatelessWidget {
  const Report({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Dúvidas críticas\nou sugestões?",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildInputField(label: "Nome*"),
              const SizedBox(height: 15),
              _buildInputField(label: "Email*"),
              const SizedBox(height: 15),
              _buildInputField(label: "Mensagem*", maxLines: 5),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF691C3A), // Usando a cor do BottomNavBar
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    // Adicione a lógica para enviar o formulário
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Formulário enviado!")),
                    );
                  },
                  child: const Text(
                    "Enviar",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir campos de entrada
  Widget _buildInputField({required String label, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xFF691C3A), width: 2.0), // Borda vinho
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xFF691C3A), width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xFF691C3A), width: 2.5), // Destaque ao focar
        ),
      ),
      style: const TextStyle(color: Colors.black), // Texto em preto
    );
  }
}
