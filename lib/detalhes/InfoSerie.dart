import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class InfoSerie extends StatefulWidget {
  final int serieId; // Recebe o ID da série selecionada

  const InfoSerie({super.key, required this.serieId});

  @override
  State<InfoSerie> createState() => _InfoSerieState();
}

class _InfoSerieState extends State<InfoSerie> {
  final String _apiKey = dotenv.env['API_KEY'] ?? '';
  final String _baseUrl = dotenv.env['BASE_URL'] ?? '';
  Map<String, dynamic>? _serieData;
  bool _isLoading = true;
  bool _isFavorite = false; // Estado do favorito

  @override
  void initState() {
    super.initState();
    fetchSerieDetails();
    _checkFavoriteStatus();
  }

  // Carregar os dados da série
  Future<void> fetchSerieDetails() async {
    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl/tv/${widget.serieId}?api_key=$_apiKey&language=pt-BR'));
      if (response.statusCode == 200) {
        setState(() {
          _serieData = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Erro ao buscar os dados da série');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  // Verificar se a série está nos favoritos
  Future<void> _checkFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList('favorites');
    if (favorites != null && favorites.contains(widget.serieId.toString())) {
      setState(() {
        _isFavorite = true;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList('favorites') ?? [];

    String serieDetails = json.encode({
      'id': widget.serieId,
      'name': _serieData!['name'],
      'poster_path': _serieData!['poster_path'],
      'vote_average': _serieData!['vote_average'],
    });

    if (_isFavorite) {
      favorites.removeWhere((item) => json.decode(item)['id'] == widget.serieId);
    } else {
      favorites.add(serieDetails);
    }

    await prefs.setStringList('favorites', favorites);
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Série'),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/w185${_serieData!['poster_path']}',
                        height: 150,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _serieData!['name'] ?? 'Título não disponível',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _serieData!['overview'] ?? 'Descrição não disponível',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Detalhes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Classificação: ${_serieData!['vote_average']} ⭐\n'
                    'Gêneros: ${(_serieData!['genres'] as List).map((g) => g['name']).join(', ')}\n'
                    'Primeira exibição: ${_serieData!['first_air_date'] ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
    );
  }
}
