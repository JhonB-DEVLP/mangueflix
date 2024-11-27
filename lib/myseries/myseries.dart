import 'package:flutter/material.dart';
import 'package:mangueflix/customappbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Importando para manipular JSON
import '../detalhes/InfoSerie.dart'; // Importando a InfoSerie para navegar até os detalhes

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

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList('favorites');

    setState(() {
      _favoriteSeries = favorites
              ?.map((e) => Map<String, dynamic>.from(json.decode(e)))
              .toList() ??
          [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackButton: true, actions: []),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft, // Alinha no canto esquerdo
                  child: const Text(
                    'Minhas séries',
                    style: TextStyle(
                      fontSize: 24, // Tamanho de fonte
                      fontWeight: FontWeight.normal, // Peso da fonte mais suave
                      color: Color(0xFF691C3A), // Cor vinho
                    ),
                  ),
                ),
              ),
              Expanded( // Permite que o GridView ocupe apenas o espaço disponível
                child: _favoriteSeries.isEmpty
                    ? const Center(
                        child: Text(
                          'Você ainda não tem séries favoritas!',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(), // Adiciona rolagem suave
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: constraints.maxWidth > 600 ? 4 : 2,
                            // 4 colunas em telas grandes, 2 em telas menores
                            childAspectRatio: 0.6, // Ajusta a proporção dos itens
                            crossAxisSpacing: 10, // Espaçamento horizontal
                            mainAxisSpacing: 10, // Espaçamento vertical
                          ),
                          itemCount: _favoriteSeries.length,
                          itemBuilder: (context, index) {
                            final serie = _favoriteSeries[index];
                            final serieId = serie['id'];
                            final serieName = serie['name'];
                            final posterPath = serie['poster_path'];
                            final voteAverage = serie['vote_average'];

                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            InfoSerie(serieId: serieId),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w185$posterPath',
                                      height: constraints.maxWidth > 600
                                          ? 200
                                          : 150, // Ajuste dinâmico de altura
                                      width: constraints.maxWidth > 600
                                          ? 120
                                          : 100, // Ajuste dinâmico de largura
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  serieName,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (starIndex) {
                                    return Icon(
                                      starIndex < (voteAverage / 2).round()
                                          ? Icons.star
                                          : Icons.star_border,
                                      color:
                                          const Color(0xFFE40624), // Cor vermelha
                                      size: 16,
                                    );
                                  }),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
     
    );
  }
}
