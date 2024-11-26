import 'package:flutter/material.dart';
import 'package:mangueflix/appbody.dart';
import 'package:mangueflix/colors/colors.dart';
import 'package:mangueflix/login/cadastro.dart';
import 'package:mangueflix/database/login.dart'; // Importa a função de login

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  // Função que será chamada ao pressionar o botão de login
  void _login() async {
    final email = emailController.text;
    final senha = senhaController.text;

    if (email.isEmpty || senha.isEmpty) {
      // Se algum campo estiver vazio
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    // Chama a função de login do backend
    final user = await loginUser(email, senha);

    if (user != null) {
      // Se o login for bem-sucedido, navega para a tela principal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AppBody()),
      );
    } else {
      // Caso contrário, exibe mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login falhou. Verifique suas credenciais')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: const Color(0xFFF1ECD6),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/image/MangueFlixLogin.png'),
              ),
              // Campo de email
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              // Campo de senha
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              // Botão de login
              Container(
                width: 250,
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.only(top: 35, bottom: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(vermelho),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  onPressed: _login, // Chama a função de login ao pressionar o botão
                ),
              ),
              // Link para cadastro
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ainda não tem sua conta?', style: TextStyle(fontSize: 16)),
                  TextButton(
                    child: const Text(
                      'Cadastre-se',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: vermelho,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Cadastro()),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
