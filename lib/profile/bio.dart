import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:mangueflix/colors/colors.dart';

class Bio extends StatefulWidget {
  const Bio({super.key});

  @override
  BioState createState() => BioState();
}

class BioState extends State<Bio> {
  String? _bio;

  @override
  void initState() {
    super.initState();
    _getBio();
  }

  // Função para buscar a biografia do usuário
  Future<void> _getBio() async {
    ParseUser? currentUser = await ParseUser.currentUser();
    if (currentUser != null) {
      String? bio = currentUser.get<String>('biografia'); // Acessa a biografia do usuário
      if (mounted) { // Verifica se o widget ainda está montado
        setState(() {
          _bio = bio ?? ''; // Se a biografia for nula, define como string vazia
        });
      }
    }
  }

  // Função para atualizar a biografia do usuário
  Future<void> _updateBio(String newBio) async {
    ParseUser? currentUser = await ParseUser.currentUser();
    if (currentUser != null) {
      currentUser.set('biografia', newBio); // Atualiza a biografia no Parse
      ParseResponse response = await currentUser.save();
      if (response.success) {
        if (mounted) { // Verifica se o widget ainda está montado
          setState(() {
            _bio = newBio; // Atualiza a biografia localmente
          });
        }
      } else {
        // Se falhar ao atualizar a biografia, mostre uma mensagem de erro
        if (mounted) { // Verifica se o widget ainda está montado antes de exibir o SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao atualizar biografia: ${response.error?.message}')),
          );
        }
      }
    }
  }

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
                  "Biografia",
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: vinho),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Quando o usuário clicar no ícone de editar, abre um campo para editar a biografia
                    _showEditBioDialog();
                  },
                ),
              ],
            ),
            subtitle: _bio == null || _bio!.isEmpty
                ? const Text(
                    'Você ainda não adicionou uma biografia.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                : Text(
                    _bio!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
          ),
        ),
      ],
    );
  }

  // Função para exibir o campo de edição da biografia
  void _showEditBioDialog() {
    TextEditingController bioController = TextEditingController(text: _bio);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Biografia'),
          content: TextField(
            controller: bioController,
            maxLines: 5,
            decoration: const InputDecoration(hintText: 'Digite sua biografia aqui...'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Atualiza a biografia com o texto digitado
                _updateBio(bioController.text);
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
