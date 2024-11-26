import 'package:flutter/material.dart';
import 'package:mangueflix/database/cadastro.dart'; // Importe a função de cadastro
import 'package:mangueflix/login/login.dart'; // Para redirecionar após o cadastro

const Color fundo = Color(0xFFf1ecd6);
const Color butao = Color(0xFFE40624);
const Color titulo = Color(0xFF691C3A);

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<Cadastro> {
  // Controladores de texto para os campos de entrada
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();

  // Função de cadastro
  void _cadastrar() async {
    final nome = _nomeController.text;
    final email = _emailController.text;
    final senha = _senhaController.text;
    final confirmarSenha = _confirmarSenhaController.text;

    // Validação de senha
    if (senha != confirmarSenha) {
      _showDialog('Erro', 'As senhas não correspondem!');
      return;
    }

    // Chama a função de cadastro do Parse
    final sucesso = await registerUser(nome, senha, email);

    if (sucesso) {
      // Se o cadastro foi bem-sucedido, redireciona para a tela de login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } else {
      _showDialog('Erro', 'Falha no cadastro!');
    }
  }

  // Função para mostrar um diálogo de erro
  void _showDialog(String titulo, String mensagem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensagem),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cadastro",
      home: Scaffold(
        backgroundColor: fundo, // Usando a cor 'fundo'
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/image/MangueFlixLogin.png'),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  controller: _senhaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: _confirmarSenhaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirmar senha',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Container(
                width: 250,
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.only(top: 35),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(butao), // Usando a variável 'butao'
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  onPressed: _cadastrar, // Chama a função de cadastro
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}