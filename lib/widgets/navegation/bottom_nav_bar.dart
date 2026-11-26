import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:train_away/navigation/reserva_reinicio.dart';

/// Barra de navegación inferior con 2 secciones principales.
/// Trabaja en conjunto con go_router para manejar la navegación.
/// El [currentPath] se obtiene del contexto del router.
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final colors = Theme.of(context).colorScheme;

    final indexInFirstPage = _getCurrentIndex(context) == 0;
    return BottomNavigationBar(
      backgroundColor: colors.surfaceDim,
      selectedItemColor: colors.inversePrimary,
      unselectedItemColor: colors.inverseSurface,
      selectedLabelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      showSelectedLabels: true,
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      // Determinamos el índice actual basándonos en la ruta actual
      currentIndex: _getCurrentIndex(context),
      onTap: (index) {
        switch (index) {
          case 0:
            // Sección "Reservar" - navegamos a la ruta inicial
            reiniciarReserva(context);
            break;
          case 1:
            // Sección "Mis reservas" - navegamos a la lista de reservas
            router.go('/mis-reservas');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            indexInFirstPage
                ? Icons.calendar_today_outlined
                : Icons.calendar_today,
            color: indexInFirstPage
                ? colors.inversePrimary
                : colors.inverseSurface,
            size: indexInFirstPage ? 36 : 26,
          ),
          label: 'Reservar',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            !indexInFirstPage ? Icons.history_sharp : Icons.history_rounded,
            color: !indexInFirstPage
                ? colors.inversePrimary
                : colors.inverseSurface,
            size: !indexInFirstPage ? 36 : 26,
          ),
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
