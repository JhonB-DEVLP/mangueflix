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
  List<dynamic> _romanceSeries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFilteredRomanceSeries();
  }

  Future<void> fetchFilteredRomanceSeries() async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl/discover/tv?api_key=$_apiKey&language=pt-BR&with_genres=10749'));
      if (response.statusCode == 200) {
        setState(() {
          _romanceSeries = json.decode(response.body)['results'];
          _isLoading = false;
        });
      } else {
        throw Exception('Erro ao buscar séries de romance');
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
                'Séries de Romance',
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
                  itemCount: _romanceSeries.length,
                  itemBuilder: (context, index) {
                    final series = _romanceSeries[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                InfoSerie(serieId: series['id']),
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
                                'https://image.tmdb.org/t/p/w200${series['poster_path']}',
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              series['name'].length > 15
                                  ? '${series['name'].substring(0, 15)}...'
                                  : series['name'],
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
