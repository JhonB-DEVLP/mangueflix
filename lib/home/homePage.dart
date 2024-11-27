import 'package:flutter/material.dart';
import 'package:mangueflix/home/requests/FilteredComedia.dart';
import 'package:mangueflix/home/requests/FilteredRomance.dart';
import 'package:mangueflix/home/requests/trending.dart';
import './requests/popularSeries.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
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
