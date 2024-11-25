import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // Importando corretamente
import 'package:mangueflix/colors/colors.dart';

class Avaliacao extends StatefulWidget {
  const Avaliacao({super.key});

  @override
  State<Avaliacao> createState() => _AvaliacaoState();
}

class _AvaliacaoState extends State<Avaliacao> {
  double _rating = 0.0;
  TextEditingController _reviewController = TextEditingController();
  TextEditingController _ratingController = TextEditingController(); // Controlador do campo de nota

  String _getRatingFeedback() {
    if (_rating >= 9.5) {
      return 'Perfeito';
    } else if (_rating >= 8.0) {
      return 'Ótimo';
    } else if (_rating >= 7.1) {
      return 'Bom';
    } else if (_rating >= 5.1) {
      return 'Mediano';
    } else if (_rating >= 3.1) {
      return 'Ruim';
    } else {
      return 'Péssimo';
    }
  }

  Color _getFeedbackColor() {
    if (_rating >= 9.5) {
      return Colors.green;
    } else if (_rating >= 8.0) {
      return Colors.green;
    } else if (_rating >= 7.1) {
      return Colors.green;
    } else if (_rating >= 5.1) {
      return Colors.blue;
    } else if (_rating >= 3.1) {
      return Colors.red;
    } else {
      return Colors.red;
    }
  }

  Color _getProgressBarColor() {
    if (_rating >= 9.5) {
      return Colors.green;
    } else if (_rating >= 8.0) {
      return Colors.green;
    } else if (_rating >= 7.1) {
      return Colors.green;
    } else if (_rating >= 5.1) {
      return Colors.blue;
    } else if (_rating >= 3.1) {
      return Colors.red;
    } else {
      return Colors.red;
    }
  }

  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nota: $_rating/10',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF500000),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        LinearProgressIndicator(
          value: _rating / 10,
          color: _getProgressBarColor(),
          backgroundColor: Colors.grey[300],
          minHeight: 6,
        ),
        SizedBox(height: 6),
        Text(
          _getRatingFeedback(),
          style: TextStyle(
            fontSize: 14,
            color: _getFeedbackColor(),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingInput() {
    return TextField(
      controller: _ratingController,
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: 'Sua nota (0 a 10)',
        hintText: 'Digite sua nota',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          _rating = double.tryParse(value) ?? 0.0;
          if (_rating > 10) _rating = 10; // Limitar o valor a 10
          if (_rating < 0) _rating = 0; // Limitar o valor a 0
        });
      },
    );
  }

  Widget _buildRevertButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _rating = 0.0;
          _ratingController.clear();
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: vermelho,
        backgroundColor: Colors.white,
        side: BorderSide(color: vermelho, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      child: Text('Reverter', style: TextStyle(fontSize: 12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(  // Permite rolar a tela
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Avaliação',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF500000),
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Classificação Geral',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF500000),
            ),
          ),
          SizedBox(height: 8),
          _buildRatingInput(),
          SizedBox(height: 12),
          _buildRevertButton(),
          SizedBox(height: 12),
          _buildProgressBar(),
          SizedBox(height: 12),
          Text(
            'Escreva sua avaliação',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF500000),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _reviewController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Escreva aqui...',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: vermelho,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
              ),
              child: Text('Avaliar', style: TextStyle(fontSize: 14)),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
