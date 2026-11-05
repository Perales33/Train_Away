import 'package:flutter/material.dart';

class FormFieldLabel extends StatelessWidget {
  const FormFieldLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      label, 
      style: const TextStyle(
        fontSize: 17, 
        fontWeight: FontWeight.w700, 
        color: Colors.black
      )
    ),
  );
}
