import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:train_away/navigation/reserva_reinicio.dart';
// Widget que muestra la barra superior común de la aplicación.
class AppBanner extends StatelessWidget implements PreferredSizeWidget {
  const AppBanner({this.onLogoTap, super.key});

  // Acción opcional al pulsar el título
  final VoidCallback? onLogoTap;

  // Altura que la barra ocupa dentro de la estructura de la pantalla.
  @override
  Size get preferredSize => const Size.fromHeight(70);

  // Construye la barra con el título, la acción de navegación y el menú.
  @override
  Widget build(BuildContext context)
  {
    final colors = Theme.of(context).colorScheme;
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: colors.surface,
      surfaceTintColor: colors.surface,
      elevation: 0,
      automaticallyImplyLeading: false,

      // Logo de la aplicación que permite reiniciar los valores de la reserva y vuelve al formulario inicial
      title: GestureDetector(
        onTap: onLogoTap ?? () => reiniciarReserva(context),
        child: Text(
          'Train Away',
          style: TextStyle(
            color: colors.inversePrimary,
            fontSize: 32,
            fontFamily: 'Corinthia',
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
          ),
        )
      ),
      
      // Acciones que aparecen al final de la barra.
      actions: [
        IconButton(
          icon: Icon(Icons.menu, size: 34, color: colors.onSurface),
          onPressed: () => context.go('/ajustes'),
        ),
      ],
      
      shape: Border(
        bottom: BorderSide(color: colors.outline, width: 1.5),
      ),
    );
  }
  
}
