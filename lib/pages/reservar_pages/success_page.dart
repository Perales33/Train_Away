import 'package:flutter/material.dart';

import 'package:train_away/theme/app_colors.dart';

// Página que confirma que la reserva se ha completado correctamente.
class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  // Construye el icono y el mensaje de confirmación.
  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(
      padding: EdgeInsets.all(28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.verified_outlined, size: 30),
          SizedBox(height: 30),
          Text(
            'La reserva se ha realizado exitosamente.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.navy,
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}
