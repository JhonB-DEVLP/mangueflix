import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mangueflix/details/avaliacao.dart';
import 'dart:convert';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../custom_app_bar.dart';


class InfoSerie extends StatefulWidget {
  final int serieId;

  const InfoSerie({super.key, required this.serieId});

  @override
  State<InfoSerie> createState() => _InfoSerieState();
}

class _InfoSerieState extends State<InfoSerie> {
  final String _apiKey = 'c00a752167d66ef3527fa00e1d21fc20';
  final String _baseUrl = 'https://api.themoviedb.org/3';
  Map<String, dynamic>? _serieData;
  bool _isLoading = true;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    fetchSerieDetails();
    _checkFavoriteStatus();
  }

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

  

// Função para salvar a série como favorita
Future<void> _saveFavorite() async {
  try {
    // Crie uma instância da classe SeriesFavoritas
    var favorite = ParseObject('SeriesFavoritas')
      ..set('serieId', widget.serieId)
      ..set('name', _serieData!['name'])
      ..set('poster_path', _serieData!['poster_path'])
      ..set('vote_average', _serieData!['vote_average']);

    // Salve o objeto no Back4App
    await favorite.save();
  } catch (e) {
    print('Erro ao salvar no banco: $e');
  }
}

// Função para remover a série das favoritas
Future<void> _removeFavorite() async {
  try {
    // Busca a série no banco
    var query = QueryBuilder<ParseObject>(ParseObject('SeriesFavoritas'))
      ..whereEqualTo('serieId', widget.serieId);
    
    var response = await query.query();
    
    if (response.success && response.results != null && response.results!.isNotEmpty) {
      // Exclui o objeto encontrado
      await response.results![0].delete();
    }
  } catch (e) {
    print('Erro ao excluir no banco: $e');
  }
}

// Modificando o método _toggleFavorite para salvar e remover do banco
Future<void> _toggleFavorite() async {
  
  if (_isFavorite) {
    await _removeFavorite();  // Remove a série das favoritas
  } else {
    await _saveFavorite();    // Adiciona a série às favoritas
  }

  setState(() {
    _isFavorite = !_isFavorite; // Altera o estado do botão
  });
}


  Widget _buildRatingStars(double rating) {
    int filledStars = (rating / 2).floor();
    bool hasHalfStar = (rating % 2) >= 1;
    return Row(
      children: [
        ...List.generate(
          filledStars,
          (index) => const Icon(Icons.star, color: Colors.red, size: 20),
        ),
        if (hasHalfStar)
          const Icon(Icons.star_half, color: Colors.red, size: 20),
        ...List.generate(
          5 - filledStars - (hasHalfStar ? 1 : 0),
          (index) => const Icon(Icons.star_border, color: Colors.red, size: 20),
        ),
        const SizedBox(width: 8),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Future<void> _checkFavoriteStatus() async {
  try {
    // Verifica se a série já está no banco
    var query = QueryBuilder<ParseObject>(ParseObject('SeriesFavoritas'))
      ..whereEqualTo('serieId', widget.serieId);
    
    var response = await query.query();

    if (response.success && response.results != null && response.results!.isNotEmpty) {
      setState(() {
        _isFavorite = true; // A série está salva como favorita
      });
    } else {
      setState(() {
        _isFavorite = false; // A série não está salva
      });
    }
  } catch (e) {
    print('Erro ao verificar se é favorita: $e');
  }
}


 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: CustomAppBar(
      showBackButton: true,
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
        : SingleChildScrollView(
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
                          Row(
                            children: [
                              Text(
                                _serieData!['name'] ?? 'Título não disponível',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF500000),
                                ),
                              ),
                              const SizedBox(width: 8), // Espaço entre o título e o ícone
                              IconButton(
                                icon: Icon(
                                  _isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _isFavorite ? Colors.red : Colors.grey,
                                ),
                                onPressed: _toggleFavorite,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _serieData!['overview'] ?? 'Descrição não disponível',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF500000),
                            ),
                            textAlign: TextAlign.justify,
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
                    color: Color(0xFF500000),
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 16),
                Text(
                  'Gêneros: ${(_serieData!['genres'] as List).map((g) => g['name']).join(', ')}\n'
                  'Primeira exibição: ${_serieData!['first_air_date'] ?? 'N/A'}\n'
                  'Temporadas: ${_serieData!['number_of_seasons']}\n'
                  'Episódios: ${_serieData!['number_of_episodes']}\n'
                  'Criadores: ${(_serieData!['created_by'] as List).map((c) => c['name']).join(', ')}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF500000),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Estrelas',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF500000),
                  ),
                ),
                _buildRatingStars(_serieData!['vote_average']),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                Avaliacao()
              ],
            ),
          ),
  );
}
}