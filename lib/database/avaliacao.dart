// ignore_for_file: avoid_print

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Função para criar avaliação
Future<bool> createAvaliacao(String descricao, double nota) async {
  // Certifique-se de que o Parse foi inicializado no início da aplicação
  await Parse().initialize(
    'ExXq7wnNW8HqYAEwDTpEtCxttozYQ3xOu6A0OGjN', // Substitua com seu App ID
    'https://parseapi.back4app.com', // Substitua com a URL do seu servidor Parse
    clientKey: 'MOlT8RuDLEu5oMln5IDRUyUh0Mm6zZJ1D9NepqgH', // Substitua com sua chave de cliente
    autoSendSessionId: true,
  );

  // Cria uma nova classe ParseObject para avaliação
  final ParseObject avaliacao = ParseObject('Avaliacao')
    ..set('descricao', descricao)
    ..set('nota', nota);

  // Aqui você precisa associar a avaliação ao usuário logado
  final ParseUser currentUser = await ParseUser.currentUser() as ParseUser;
  avaliacao.set('user', currentUser);

  // Salva a avaliação no banco de dados
  final ParseResponse response = await avaliacao.save();

  // Verifica se a operação foi bem-sucedida
  if (response.success) {
    print('Avaliação criada com sucesso!');
    return true;
  } else {
    print('Erro ao criar avaliação: ${response.error?.message}');
    return false;
  }
}

class Avaliacao {
  final String descricao;
  final double nota;

  Avaliacao({required this.descricao, required this.nota});

  // Construtor de fábrica para criar um objeto Avaliacao a partir de um ParseObject
  factory Avaliacao.fromParseObject(ParseObject object) {
    return Avaliacao(
      descricao: object.get<String>('descricao') ?? '',  // Descrição da avaliação
      nota: object.get<double>('nota') ?? 0.0,            // Nota da avaliação
    );
  }
}

Future<List<Avaliacao>> getHistoricoAvaliacoes() async {
  // Inicializa o Parse apenas uma vez, no início do ciclo de vida do aplicativo (idealmente em main.dart)
  await Parse().initialize(
    'ExXq7wnNW8HqYAEwDTpEtCxttozYQ3xOu6A0OGjN', // Substitua com seu App ID
    'https://parseapi.back4app.com',              // URL do servidor Parse
    clientKey: 'MOlT8RuDLEu5oMln5IDRUyUh0Mm6zZJ1D9NepqgH', // Substitua com sua chave de cliente
    autoSendSessionId: true,
  );

  // Obtém o usuário atual
  final ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;

  // Verifica se o usuário está logado
  if (currentUser == null) {
    print('Usuário não está logado');
    return [];  // Retorna uma lista vazia caso não haja usuário logado
  }

  // Cria a consulta para a classe 'Avaliacao'
  final QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(ParseObject('Avaliacao'));

  // Filtra pela associação com o usuário logado
  query.whereEqualTo('user', currentUser);

  // Executa a consulta e obtém a resposta
  final ParseResponse response = await query.query();

  // Se a consulta for bem-sucedida, retorna as avaliações
  if (response.success && response.results != null) {
    List<Avaliacao> historico = [];
    for (var object in response.results!) {
      // Cada resultado é um ParseObject, você pode acessar os dados como um Map
      var avaliacao = object as ParseObject;
      historico.add(Avaliacao.fromParseObject(avaliacao));  // Cria o objeto Avaliacao a partir do ParseObject
    }
    return historico;
  } else {
    print('Erro ao obter o histórico de avaliações: ${response.error?.message}');
    return [];  // Retorna uma lista vazia em caso de erro
  }
}

