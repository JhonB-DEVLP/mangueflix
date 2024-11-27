import 'package:flutter/material.dart';
import 'package:mangueflix/colors/colors.dart'; // Certifique-se de que a cor "vinho" esteja definida.
import 'package:mangueflix/database/avaliacao.dart'; // Importe o serviço que contém a função getHistoricoAvaliacoes

class HistAval extends StatelessWidget {
  const HistAval({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Avaliacao>>( // Agora o tipo é List<Avaliacao>
      future: getHistoricoAvaliacoes(), // Função que retorna a lista de avaliações
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Erro ao carregar histórico de avaliações: ${snapshot.error}',
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: const Text(
              'Nenhuma avaliação encontrada.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        final historico = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.all(16.0), // Adiciona espaçamento ao redor da tela
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Histórico de Avaliações",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: vinho, // Use a mesma cor da Bio
                ),
              ),
              const SizedBox(height: 16), // Uso de SizedBox para o espaço
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6, // Defina a altura aqui (60% da altura da tela)
                child: ListView.builder(
                  itemCount: historico.length,
                  itemBuilder: (context, index) {
                    final avaliacao = historico[index];
                    return Card(
                      elevation: 2,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 400, 
                          minHeight: 120, 
                        ),
                        padding: const EdgeInsets.all(8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Avaliação ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: vinho, // Use a cor definida
                                ),
                              ),
                              Text(
                                '${avaliacao.nota} ⭐', // Acessando a propriedade 'nota' de Avaliacao
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: vinho,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            avaliacao.descricao.isNotEmpty ? avaliacao.descricao : 'Sem descrição', // Acessando a propriedade 'descricao' de Avaliacao
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
