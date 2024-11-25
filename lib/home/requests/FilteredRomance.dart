import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mangueflix/detalhes/InfoSerie.dart';

class FilteredRomance extends StatefulWidget {
  const FilteredRomance({super.key});

  @override
  FilteredRomanceState createState() => FilteredRomanceState();
}

class FilteredRomanceState extends State<FilteredRomance> {
  final String _apiKey = 'c00a752167d66ef3527fa00e1d21fc20';
  final String _baseUrl = 'https://api.themoviedb.org/3';
  List<dynamic> _Romance = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFilteredRomance();
  }

  Future<void> fetchFilteredRomance() async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl/discover/movie?api_key=$_apiKey&language=pt-BR&with_genres=10749'));
      if (response.statusCode == 200) {
        setState(() {
          _Romance = json.decode(response.body)['results'];
          _isLoading = false;
        });
      } else {
        throw Exception('Erro ao buscar filmes de comédia');
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
                'Filmes de Romance',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  scrollDirection: Axis.horizontal, // Carrossel horizontal
                  itemCount: _Romance.length,
                  itemBuilder: (context, index) {
                    final romance = _Romance[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                InfoSerie(serieId: romance['id']),
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
                                'https://image.tmdb.org/t/p/w200${romance['poster_path']}',
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              romance['title'].length > 15
                                  ? '${romance['title'].substring(0, 15)}...'
                                  : romance['title'],
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
