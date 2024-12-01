import 'package:flutter/material.dart';
import 'package:mangueflix/details/info_serie.dart';
import 'package:mangueflix/home/requests/filtered_comedia.dart';
import 'package:mangueflix/home/requests/filtered_romance.dart';
import 'package:mangueflix/home/requests/trending.dart';
import 'requests/popular_series.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController(); // Controlador do campo de pesquisa
  final String _apiKey = 'c00a752167d66ef3527fa00e1d21fc20';
  final String _baseUrl = 'https://api.themoviedb.org/3';
  List<dynamic> _searchResults = []; // Para armazenar os resultados da pesquisa
  bool _isLoading = false; // Para controlar o carregamento
  bool _hasSearched = false; // Para verificar se o usuário pesquisou

  // Função para buscar séries com base no termo de pesquisa
  Future<void> _searchSeries(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _hasSearched = false; // Indica que o usuário não pesquisou nada
      });
      return; // Não faz a pesquisa se o campo estiver vazio
    }

    setState(() {
      _isLoading = true; // Inicia o carregamento
      _hasSearched = true; // Marca que o usuário fez uma pesquisa
    });

    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl/search/tv?api_key=$_apiKey&language=pt-BR&query=$query'));

      if (response.statusCode == 200) {
        setState(() {
          _searchResults = json.decode(response.body)['results']; // Armazena os resultados
          _isLoading = false; // Finaliza o carregamento
        });
      } else {
        throw Exception('Erro ao buscar as séries');
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Finaliza o carregamento
      });
      print('Erro: $e');
    }
  }

  // Navegar para a tela de detalhes da série
  void _navigateToDetails(int id) {
    // Aqui, você pode navegar para uma tela de detalhes (precisa de uma tela de detalhes)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InfoSerie(serieId: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1ECD6),  // Definindo a cor de fundo no Scaffold
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _searchController, // Conecta o controlador de texto
                onChanged: _searchSeries, // Chama a função de pesquisa quando o texto mudar
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: const Color(0xffffffff),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.red,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1.5,
                    ),
                  ),
                  hintText: 'Pesquise Séries',
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.5,
                    ),
                  ),
                ),
              ),
            ),
            if (_isLoading) const CircularProgressIndicator(), // Mostra um indicador de carregamento
            if (_hasSearched && _searchResults.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Nenhum resultado encontrado.'),
              ),
            if (!_isLoading && _searchResults.isNotEmpty) 
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: _searchResults.map<Widget>((serie) {
                    return ListTile(
                      title: Text(serie['name']),
                      subtitle: Text(serie['overview'] ?? 'Sem descrição'),
                      leading: Image.network(
                        'https://image.tmdb.org/t/p/w185${serie['poster_path']}',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      onTap: () => _navigateToDetails(serie['id']), // Navega para a tela de detalhes
                    );
                  }).toList(),
                ),
              ),
            SizedBox(
              height: 300,
              child: PopularSeries(),
            ),
            SizedBox(
              height: 300,
              child: Tendencias(),
            ),
            SizedBox(
              height: 300,
              child: FilteredComedia(),
            ),
            SizedBox(
              height: 300,
              child: FilteredRomance(),
            ),
          ],
        ),
      ),
    );
  }
}