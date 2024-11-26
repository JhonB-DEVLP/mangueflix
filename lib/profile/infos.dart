import 'package:flutter/material.dart';
import 'package:mangueflix/colors/colors.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Infos extends StatelessWidget {
  const Infos({super.key});

  Future<String?> _getUserName() async {
    // Obtém o usuário atual da sessão
    ParseUser? currentUser = await ParseUser.currentUser();
    if (currentUser != null) {
      // Retorna o nome do usuário (campo correto: 'nome')
      return currentUser.get<String>('nome'); // Altere 'nome' para o nome do campo correto
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getUserName(), // Chama a função para pegar o nome do usuário
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Carregando
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Usuário não encontrado.'));
        } else {
          String userName = snapshot.data!; // Pega o nome do usuário
          return Column(
            children: [
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: ListTile(
                  leading: Icon(
                    Icons.person, // Ícone do perfil
                    size: 40, // Tamanho do ícone
                    color: vinho, // Cor do ícone, você pode alterar para o que preferir
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userName, // Exibe o nome do usuário
                        style: const TextStyle(
                          color: vinho,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
