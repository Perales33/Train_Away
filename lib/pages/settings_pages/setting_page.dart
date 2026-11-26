import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_away/providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Ajustes', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('Modo oscuro'),
          subtitle: const Text('Cambiar la apariencia de la aplicación'),
          secondary: Icon(
            isDarkMode ? Icons.dark_mode : Icons.light_mode,
          ),
          value: isDarkMode,
          onChanged: (_) {
            context.read<ThemeProvider>().toggleTheme();
          },
        ),
      ],
    );
  }
}