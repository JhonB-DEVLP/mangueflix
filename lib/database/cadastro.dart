// ignore_for_file: avoid_print

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

Future<bool> registerUser(String nome, String senha, String email) async {
  // Defina as configurações do Parse (caso ainda não tenha feito isso no seu app)
  await Parse().initialize(
    'ExXq7wnNW8HqYAEwDTpEtCxttozYQ3xOu6A0OGjN', // Substitua com seu App ID
    'https://parseapi.back4app.com', // Substitua com a URL do seu servidor Parse
    clientKey: 'MOlT8RuDLEu5oMln5IDRUyUh0Mm6zZJ1D9NepqgH', // Substitua com sua chave de cliente
    autoSendSessionId: true,
  );

  // Criar um novo ParseUser
  final ParseUser parseUser = ParseUser(email, senha, email);

  // Adicionar dados adicionais ao usuário (como nome)
  parseUser.set('nome', nome);

  // Salvar o novo usuário no Parse
  final ParseResponse response = await parseUser.signUp();

  // Verificar se o cadastro foi bem-sucedido
  if (response.success) {
    // Cadastro realizado com sucesso
    return true;
  } else {
    // Ocorreu um erro ao tentar cadastrar o usuário
    print('Erro ao cadastrar: ${response.error?.message}');
    return false;
  }
}