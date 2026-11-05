import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

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
              fontWeight: FontWeight.w700
            )
          ),
        ]
      ),
    ),
  );
}
