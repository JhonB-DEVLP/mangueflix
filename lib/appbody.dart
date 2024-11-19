import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mangueflix/myDrawer.dart';
import 'package:mangueflix/colors/colors.dart';
import 'package:mangueflix/profile/profile.dart';
import './detalhes/InfoSerie.dart';

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  _AppBodyState createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  final String _apiKey = 'c00a752167d66ef3527fa00e1d21fc20'; 
  final String _baseUrl = 'https://api.themoviedb.org/3'; 
  List<dynamic> _series = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSeries();
  }

  Future<void> fetchSeries() async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl/discover/tv?api_key=$_apiKey&language=pt-BR&sort_by=popularity.desc'));
      if (response.statusCode == 200) {
        setState(() {
          _series = json.decode(response.body)['results'];
          _isLoading = false;
        });
      } else {
        throw Exception('Erro ao buscar as séries');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: IconButton(
            icon: Image.asset('assets/image/mangueFlix.png'),
            iconSize: 50,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AppBody()),
              );
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/image/fotoFlutter.png'),
            iconSize: 50,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: const Color(0xffffffff),
                prefixIcon: const Icon(
                  Icons.search,
                  color: vermelho,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: vermelho,
                    width: 1.5,
                  ),
                ),
                hintText: 'Pesquise Séries',
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: vermelho,
                    width: 2.5,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal, // Carrossel horizontal
                    itemCount: _series.length,
                    itemBuilder: (context, index) {
                      final serie = _series[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  InfoSerie(serieId: serie['id']),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w200${serie['poster_path']}',
                                  width: 100, // Tamanho restaurado
                                  height: 150, // Tamanho restaurado
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
