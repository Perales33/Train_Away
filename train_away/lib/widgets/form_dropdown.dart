import 'package:flutter/material.dart';

import 'package:train_away/theme/app_colors.dart';

class FormDropdown<T> extends StatelessWidget {
  const FormDropdown({
    required this.value,
    required this.values,
    required this.onChanged,
    this.hint,
    super.key,
  });

  final T value;
  final List<T> values;
  final ValueChanged<T?> onChanged;
  final String? hint;

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<T>(
    borderRadius: BorderRadius.circular(15),

    dropdownColor: AppColors.surfaceGrey,
    value: value,
    isExpanded: true,
    icon: const Icon(
      Icons.keyboard_arrow_down,
      size: 26,
      color: AppColors.navy,
    ),
    hint: hint == null ? null : Text(hint ?? ''),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.navy, width: 2.5),
        borderRadius: BorderRadius.circular(12),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.darkColor, width: 2.5),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    style: const TextStyle(
      color: AppColors.darkColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),

    items: values
        .map(
          (item) => DropdownMenuItem<T>(
            value: item,
            child: Text(
              item == null ? 'N/A' : item.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
        .toList(),

    onChanged: onChanged,
  );
}
