import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mangueflix/details/info_serie.dart';

class FilteredComedia extends StatefulWidget {
  const FilteredComedia({super.key});

  @override
  FilteredComediaState createState() => FilteredComediaState();
}

class FilteredComediaState extends State<FilteredComedia> {
  final String _apiKey = 'c00a752167d66ef3527fa00e1d21fc20';
  final String _baseUrl = 'https://api.themoviedb.org/3';
  List<dynamic> _comedia = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFilteredComedia();
  }

  Future<void> fetchFilteredComedia() async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl/discover/tv?api_key=$_apiKey&language=pt-BR&with_genres=35'));
      if (response.statusCode == 200) {
        setState(() {
          _comedia = json.decode(response.body)['results'];
          _isLoading = false;
        });
      } else {
        throw Exception('Erro ao buscar séries de comédia');
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
                'Séries de Comédia',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250, // Ajuste a altura conforme necessário
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  scrollDirection: Axis.horizontal, // Carrossel horizontal
                  itemCount: _comedia.length,
                  itemBuilder: (context, index) {
                    final comedia = _comedia[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                InfoSerie(serieId: comedia['id']),
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
                                'https://image.tmdb.org/t/p/w200${comedia['poster_path']}',
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              comedia['name'].length > 15
                                  ? '${comedia['name'].substring(0, 15)}...'
                                  : comedia['name'],
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
