import 'package:flutter/material.dart';

// Widget de diálogo que solicita confirmar o cancelar la reserva.
class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key});
  
  // Construye el aviso y los botones para responder.
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(15),
        side: BorderSide(color: colors.scrim, width: 4),
      ),
      backgroundColor: colors.shadow,
      
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
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                  ),
                  border: BoxBorder.all(color: colors.scrim, width: 2),
                ),
        
                child: TextButton(
                  style: FilledButton.styleFrom(
                    foregroundColor: colors.onSurface,
                  ),
                  onPressed: () { Navigator.of(context).pop<bool>(false); },
                  child: Text(
                    'No',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.onSurface,
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
        
                  border: BoxBorder.all(color: colors.outline, width: 2),
                ),
                child: TextButton(
                  style: FilledButton.styleFrom(
                    foregroundColor: colors.onSurface,
                  ),
                  onPressed: () { Navigator.of(context).pop<bool>(true); },
                  child: Text(
                    'Sí',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
