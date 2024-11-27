import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Biblioteca para usar SVG
import 'package:mangueflix/colors/colors.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: vinho, // Cor de fundo geral do Drawer
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ícone de 3 barras para fechar o Drawer
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              iconSize: 28,
              onPressed: () {
                Navigator.pop(context); // Fecha o Drawer
              },
            ),
          ),

          // Item: Tela Principal
          _buildDrawerItem(
            context,
            icon: Icons.home,
            label: "Tela Principal",
            iconColor: vinho,
            textColor: vinho,
            backgroundColor: Colors.white, // Fundo branco para destaque
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.pushNamed(
                  context, '/home'); // Vai para a tela principal
            },
          ),

          // Item: Tela Report
          _buildDrawerItem(
            context,
            icon: Icons.report_problem,
            label: "Tela Report",
            iconColor: Colors.white,
            textColor: Colors.white,
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.pushNamed(
                  context, '/report'); // Vai para a tela principal
            },
          ),

          // Item: Sobre o MangueFlix
          _buildDrawerItemWithSvg(
            context,
            svgPath: 'assets/image/crabIcon.svg',
            label: "Sobre o MangueFlix",
            textColor: Colors.white,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about'); // Vai para a tela Sobre
            },
          ),

          // Item: Configurações (exemplo, caso adicione uma tela de configurações)
          _buildDrawerItem(
            context,
            icon: Icons.settings,
            label: "Configurações",
            iconColor: Colors.white,
            textColor: Colors.white,
            onTap: () {
              print("Configurações não implementadas ainda");
            },
          ),

          // Item: Sair
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            label: "Sair",
            iconColor: Colors.white,
            textColor: Colors.white,
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.pushReplacementNamed(
                  context, '/'); // Volta para a tela de Login
            },
          ),
        ],
      ),
    );
  }

  // Método para construir itens do Drawer com suporte a fundo customizado
  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color iconColor,
    required Color textColor,
    Color? backgroundColor, // Fundo opcional (padrão: transparente)
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor, // Aplica fundo se fornecido
        border: Border.all(color: Colors.white, width: 0.1),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor,
        ),
        title: Text(
          label,
          style: TextStyle(color: textColor),
        ),
        onTap: onTap,
      ),
    );
  }

  // Método para construir itens com ícones SVG
  Widget _buildDrawerItemWithSvg(
    BuildContext context, {
    required String svgPath,
    required String label,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.1),
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          svgPath,
          width: 24,
          height: 24,
          color: Colors.white,
        ),
        title: Text(
          label,
          style: TextStyle(color: textColor),
        ),
        onTap: onTap,
      ),
    );
  }
}
