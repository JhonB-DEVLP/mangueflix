import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mangueflix/detalhes/InfoSerie.dart';

class Tendencias extends StatefulWidget {
  const Tendencias({super.key});

  @override
  _TendenciasState createState() => _TendenciasState();
}

class _TendenciasState extends State<Tendencias> {
  final String _apiKey = 'c00a752167d66ef3527fa00e1d21fc20';
  final String _baseUrl = 'https://api.themoviedb.org/3';
  List<dynamic> _tendencias = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTendencias();
  }

  Future<void> fetchTendencias() async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl/trending/tv/week?api_key=$_apiKey&language=pt-BR'));
      if (response.statusCode == 200) {
        setState(() {
          _tendencias = json.decode(response.body)['results'];
          _isLoading = false;
        });
      } else {
        throw Exception('Erro ao buscar as tendências');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tendências',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16), // Espaçamento entre o título e as imagens
        SizedBox(
          height: 250,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  scrollDirection: Axis.horizontal, // Carrossel horizontal
                  itemCount: _tendencias.length,
                  itemBuilder: (context, index) {
                    final tendencia = _tendencias[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                InfoSerie(serieId: tendencia['id']),
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
                                'https://image.tmdb.org/t/p/w200${tendencia['poster_path']}',
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              tendencia['name'].length > 15
                                  ? '${tendencia['name'].substring(0, 15)}...'
                                  : tendencia['name'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
