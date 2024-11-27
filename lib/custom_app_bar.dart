import 'package:flutter/material.dart';
import 'package:mangueflix/colors/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    this.showBackButton = false,
    required List<IconButton> actions,
  });

  @override
  Widget build(BuildContext context) {
    // Obtém a rota atual
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(
        color: vinho, // Cor dos ícones (incluindo o menu hambúrguer)
      ),
      title: Center(
        child: IconButton(
          icon: Image.asset('assets/image/mangueFlix.png'),
          iconSize: 50,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/',
              (route) => false,
            );
          },
        ),
      ),
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: vermelho),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      actions: currentRoute != '/profile'
          ? [
              IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  size: 50,
                  color: vinho, // Cor do ícone de usuário
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ]
          : null, // Remove o botão de perfil se já estiver na rota '/profile'
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
