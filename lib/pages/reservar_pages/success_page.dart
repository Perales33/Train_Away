import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:train_away/widgets/elements_styles/bottom_button.dart';
import 'package:train_away/navigation/reserva_reinicio.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified_outlined,
                      size: 30,
                      color: colors.primary,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'La reserva se ha realizado exitosamente.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: AppBottomButton(
                  label: 'Entendido',
                  outlined: true,
                  onPressed: () => reiniciarReserva(context),
                ), 
              ),
              Expanded(
                child: AppBottomButton(
                  label: 'Mis reservas ',
                  outlined: false,
                  onPressed: () => context.go('/mis-reservas'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
