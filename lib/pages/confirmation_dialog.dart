import 'package:flutter/material.dart';
import 'package:train_away/theme/app_colors.dart';

// Widget de diálogo que solicita confirmar o cancelar la reserva.
class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    required this.onCancel,
    required this.onConfirm,
    super.key,
  });

  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  // Construye el aviso y los botones para responder.
  @override
  Widget build(BuildContext context) => AlertDialog(
    actionsAlignment: MainAxisAlignment.center,
    actionsPadding: EdgeInsets.all(0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(15),
      side: BorderSide(color: AppColors.black, width: 4),
    ),
    
    title: Center(
      child: const Text(
        'Vas a confirmar tu reserva',
        style: TextStyle(fontWeight: FontWeight(900), fontSize: 22),
      ),
    ),

    content: const Text(
      'Una vez confirmada, no podrás anularla. ¿Confirmas la reserva?',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight(600), fontSize: 16),
    ),

    // Definimos las acciones del dialogo, en caso de que sí va a la pantalla de confirmación, y en el caso de que no, vuelve al formulario de reserva.
    actions: [
      Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                  ),
                  border: BoxBorder.all(color: AppColors.black, width: 2),
                ),

                child: TextButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.transparent,
                  ),
                  onPressed: onCancel,
                  child: const Text(
                    'No',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                  ),

                  border: BoxBorder.all(color: AppColors.black, width: 2),
                ),
                child: TextButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.transparent,
                  ),
                  onPressed: onConfirm,
                  child: const Text(
                    'Sí',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
