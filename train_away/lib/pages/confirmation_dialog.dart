import 'package:flutter/material.dart';

class BookingConfirmationDialog extends StatelessWidget {
  const BookingConfirmationDialog({
    required this.onCancel,
    required this.onConfirm,
    super.key,
  });

  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) => AlertDialog(
    actionsAlignment: MainAxisAlignment.center,
    actionsPadding: EdgeInsets.all(0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(15),
      side: BorderSide(color: Colors.black, width: 4),
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
                  border: BoxBorder.all(color: Colors.black, width: 2),
                ),

                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: onCancel,
                  child: const Text(
                    'No',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
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

                  border: BoxBorder.all(color: Colors.black, width: 2),
                ),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: onConfirm,
                  child: const Text(
                    'Sí',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
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
