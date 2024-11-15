import 'package:flutter/material.dart';
import 'package:mangueflix/appbody.dart';
import 'package:mangueflix/colors/colors.dart';
import 'package:mangueflix/login/cadastro.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<Login> {
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
                      child: Image.asset('assets/image/MangueFlixLogin.png')),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Login',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Senha',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                      width: 250,
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      margin: const EdgeInsets.only(top: 35, bottom: 20),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(vermelho),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AppBody()),
                          );
                        },
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Ainda não tem sua conta?',
                          style: TextStyle(fontSize: 16)),
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
                            MaterialPageRoute(
                                builder: (context) => const Cadastro()),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ))),
    );
  }
}
