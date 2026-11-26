import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Barra de navegación inferior con 2 secciones principales.
/// Trabaja en conjunto con go_router para manejar la navegación.
/// El [currentPath] se obtiene del contexto del router.
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    return BottomNavigationBar(
      // Determinamos el índice actual basándonos en la ruta actual
      currentIndex: _getCurrentIndex(context),
      onTap: (index) {
        switch (index) {
          case 0:
            // Sección "Reservar" - navegamos a la ruta inicial
            router.go('/reservar');
            break;
          case 1:
            // Sección "Mis reservas" - navegamos a la lista de reservas
            router.go('/mis-reservas');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Reservar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Mis reservas',
        ),
      ],
    );
  }

  // Método auxiliar para determinar el índice actual basado en la ruta
  int _getCurrentIndex(BuildContext context) {
    final path = GoRouter.of(context).routeInformationProvider.value.uri.path;
    if (path.startsWith('/mis-reservas')) return 1;
    if (path.startsWith('/reservar')) return 0;
    return 0;
  }
}
