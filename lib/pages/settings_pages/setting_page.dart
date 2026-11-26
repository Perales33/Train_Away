import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_away/providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    final colors = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Ajustes', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        SwitchListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          activeThumbColor: colors.inverseSurface,
          tileColor: colors.inversePrimary.withAlpha(13),
          title: const Text(
            'Modo oscuro',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: const Text('Cambiar la apariencia de la aplicación'),
          secondary: Icon(
            isDarkMode ? Icons.dark_mode : Icons.light_mode,
            color: colors.inverseSurface,
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
