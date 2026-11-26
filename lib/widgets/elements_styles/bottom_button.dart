import 'package:flutter/material.dart';

// Widget que coloca un botón en la parte inferior de las pantallas.
class AppBottomButton extends StatelessWidget {
  const AppBottomButton({
    required this.label,
    required this.onPressed,
    this.outlined = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final bool outlined;

  // Construye el contenedor inferior y el estilo de botón solicitado.
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.outlineVariant)),
      ),
      child: Center(
        child: SizedBox(
          width: 192,
          height: 46,
          // Dependiendo del valor del booleano pasado, el botón se mostrará con un estilo u otro
          child: outlined
              ? OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.primary,
                    side: BorderSide(
                      color: colors.onSurfaceVariant,
                      width: 2.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  onPressed: onPressed,
                  child: Text(
                    label,
                    style: TextStyle(
                      color: colors.inverseSurface,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                )
              : FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: colors.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  onPressed: onPressed,
                  child: Text(
                    label,
                    style: TextStyle(
                      color: colors.onSecondary,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
