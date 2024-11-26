import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Função que realiza o login do usuário
Future<ParseUser?> loginUser(String email, String senha) async {
  // Certifique-se de que o Parse foi inicializado no início da aplicação
  await Parse().initialize(
    'ExXq7wnNW8HqYAEwDTpEtCxttozYQ3xOu6A0OGjN', // Substitua com seu App ID
    'https://parseapi.back4app.com', // Substitua com a URL do seu servidor Parse
    clientKey: 'MOlT8RuDLEu5oMln5IDRUyUh0Mm6zZJ1D9NepqgH', // Substitua com sua chave de cliente
    autoSendSessionId: true,
  );

  // Cria um ParseUser com os dados de email e senha
  final ParseUser user = ParseUser(email, senha, email);

  // Tenta realizar o login
  final ParseResponse response = await user.login();

  // Verifica se o login foi bem-sucedido
  if (response.success) {
    // Retorna o usuário autenticado
    return response.result as ParseUser?;
  } else {
    // Se o login falhou, exibe o erro
    print('Erro ao fazer login: ${response.error?.message}');
    return null; // Retorna null caso o login falhe
  }
}