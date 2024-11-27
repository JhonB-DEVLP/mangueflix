import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F2E7), // Cor bege
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color(0xFFE40624)), // Seta red
          onPressed: () {
            Navigator.pop(context); // Retorna para a tela anterior
          },
        ),
        title: Image.asset(
          'assets/image/mangueFlix.png', // Logo centralizada
          height: 80, // Tamanho da logo igual à tela "Home"
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/image/fotoFlutter.png'), // Foto de perfil
            ),
          ),
        ],
      ),
      body: Column(
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
          Expanded(
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // 4 colunas
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
                                  height: 150, // Altura ajustada
                                  width: 100, // Largura ajustada
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
                                  color: const Color(0xFFE40624), // Cor red
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF691C3A), // Cor vinho
        selectedItemColor: Colors.white, // Cor dos ícones selecionados
        unselectedItemColor: Colors.white60, // Cor dos ícones não selecionados
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Ícone de "home"
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite), // Ícone de "favoritos"
            label: '',
          ),
        ],
      ),
    );
  }
}
