import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';  // Importando para manipular JSON
import '../detalhes/InfoSerie.dart';  // Importando a InfoSerie para navegar até os detalhes

class MySeries extends StatefulWidget {
  const MySeries({super.key});

  @override
  State<MySeries> createState() => _MySeriesState();
}

class _MySeriesState extends State<MySeries> {
  List<Map<String, dynamic>> _favoriteSeries = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  // Carregar as séries favoritas com informações completas
  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList('favorites');
    
    // Carregar os favoritos e converter de JSON para Map
    setState(() {
      _favoriteSeries = favorites?.map((e) => Map<String, dynamic>.from(json.decode(e))).toList() ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Séries Favoritas'),
      ),
      body: _favoriteSeries.isEmpty
          ? const Center(child: Text('Você ainda não tem séries favoritas!'))
          : ListView.builder(
              itemCount: _favoriteSeries.length,
              itemBuilder: (context, index) {
                final serie = _favoriteSeries[index];
                final serieId = serie['id'];
                final serieName = serie['name'];
                final posterPath = serie['poster_path'];
                final voteAverage = serie['vote_average'];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w185$posterPath',
                    height: 100,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                  title: Text(serieName),
                  subtitle: Row(
                    children: List.generate(5, (starIndex) {
                      return Icon(
                        starIndex < (voteAverage / 2).round()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.yellow,
                        size: 20,
                      );
                    }),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InfoSerie(serieId: serieId),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
