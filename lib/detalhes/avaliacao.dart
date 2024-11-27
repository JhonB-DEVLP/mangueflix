import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mangueflix/colors/colors.dart';
import 'package:mangueflix/database/avaliacao.dart';

class Avaliacao extends StatefulWidget {
  const Avaliacao({super.key});

  @override
  State<Avaliacao> createState() => _AvaliacaoState();
}

class _AvaliacaoState extends State<Avaliacao> {
  double _rating = 0.0;
  TextEditingController _reviewController = TextEditingController();
  TextEditingController _ratingController =
      TextEditingController(); // Controlador do campo de nota

  String? _errorMessage; // Variável para armazenar a mensagem de erro

  // Função para determinar o feedback da avaliação
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

  // Função para determinar a cor do feedback
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

  // Função para determinar a cor da barra de progresso
  Color _getProgressBarColor() {
    return _getFeedbackColor(); // Reaproveita a função _getFeedbackColor para simplificar
  }

  // Construção da barra de progresso
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
          value: _rating >= 0 && _rating <= 10
              ? _rating / 10
              : 0, // Atualiza a barra apenas se o valor for válido
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
        // Exibe a mensagem de erro, se houver
        if (_errorMessage != null)
          Text(
            _errorMessage!,
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
      ],
    );
  }

  // Campo de entrada para a nota
  Widget _buildRatingInput() {
    return TextField(
      controller: _ratingController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]+$'))
      ],
      decoration: InputDecoration(
        labelText: 'Sua nota (0 a 10)',
        hintText: 'Digite sua nota',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          _rating = double.tryParse(value) ?? 0.0;

          if (_rating > 10) {
            _errorMessage = 'A nota não pode ser maior que 10.';
            _rating = 10; // Limitar o valor a 10
          } else if (_rating < 0) {
            _errorMessage = 'A nota não pode ser menor que 0.';
            _rating = 0; // Limitar o valor a 0
          } else {
            _errorMessage =
                null; // Reseta a mensagem de erro se o valor for válido
          }
        });
      },
    );
  }

  // Botão para reverter a avaliação
  Widget _buildRevertButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _rating = 0.0;
          _ratingController.clear();
          _errorMessage = null; // Limpa a mensagem de erro ao reverter
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

  Future<void> _submitAvaliacao() async {
    String descricao = _reviewController.text;
    String ratingText = _ratingController.text;
    double nota = double.tryParse(ratingText) ?? 0.0;

    // Valida se todos os campos estão preenchidos e se a nota está dentro do intervalo
    if (descricao.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Por favor, preencha todos os campos corretamente.')),
      );
      return;
    }
    // Valida se todos os campos estão preenchidos e se a nota está dentro do intervalo
    if (nota < 0 || nota > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Nota inválida, preencha um valor entre 0 e 10')),
      );
      return;
    }

    // Chama a função para salvar a avaliação no banco de dados
    bool sucesso = await createAvaliacao(descricao, nota);

    if (sucesso) {
      // Exibe uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Avaliação enviada com sucesso!')),
      );
      // Limpa os campos após o envio
      setState(() {
        _rating = 0.0;
        _ratingController.clear();
        _reviewController.clear();
        _errorMessage = null; // Limpa a mensagem de erro
      });
    } else {
      // Exibe uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar a avaliação.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              onPressed:
                  _submitAvaliacao, // Chama a função de enviar a avaliação
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: vermelho,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
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
