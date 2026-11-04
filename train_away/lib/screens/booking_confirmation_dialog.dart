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
        title: const Text('Vas a confirmar tu reserva'),
        content: const Text('Una vez confirmada, no podrás anularla. ¿Confirmas la reserva?'),
        actions: [
          TextButton(onPressed: onCancel, child: const Text('No')),
          FilledButton(onPressed: onConfirm, child: const Text('Sí')),
        ],
      );
}
