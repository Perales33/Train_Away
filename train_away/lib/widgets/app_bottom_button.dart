import 'package:flutter/material.dart';

import 'package:train_away/theme/app_colors.dart';

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

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: AppColors.divider)),
    ),
    child: Center(
      child: SizedBox(
        width: 192,
        height: 46,
        child: outlined
          ? OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.navy,
                side: const BorderSide(color: AppColors.navy, width: 2.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              onPressed: onPressed,
              child: Text(label),
            )
          : FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.navy,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              onPressed: onPressed,
              child: Text(label),
            ),
      ),
    ),
  );
}
