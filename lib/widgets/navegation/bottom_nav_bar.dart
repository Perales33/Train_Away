import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:train_away/navigation/reserva_reinicio.dart';

/// Barra de navegación inferior con 2 secciones principales.
/// Trabaja en conjunto con go_router para manejar la navegación.
/// El [currentPath] se obtiene del contexto del router.
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({required this.currentPath, super.key});

  final String currentPath;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final currentIndex = currentPath.startsWith('/mis-reservas') ? 1 : 0;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) {
          reiniciarReserva(context);
        } else {
          context.go('/mis-reservas');
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          backgroundColor: colors.inversePrimary,
          label: 'Reservar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Mis reservas',
        ),
      ],
    );
  }
}
