import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:train_away/data/reservation_database.dart';
import 'package:train_away/pages/mis_reservas_pages/pages/mis_reservas_page.dart';
import 'package:train_away/pages/mis_reservas_pages/pages/reserva_detalle_page.dart';

import 'package:train_away/models/clases_reserva/reserva_model.dart';
import 'package:train_away/pages/reservar_pages/date_time_page.dart';
import 'package:train_away/pages/reservar_pages/reservation_confirmed.dart';
import 'package:train_away/pages/reservar_pages/success_page.dart';
import 'package:train_away/pages/reservar_pages/form_page.dart';
import 'package:train_away/pages/settings_pages/setting_page.dart';
import 'package:train_away/providers/last_train_provider.dart';
import 'package:train_away/providers/reservas_provider.dart';
import 'package:train_away/providers/theme_provider.dart';
import 'package:train_away/widgets/navegation/bottom_nav_bar.dart';
import 'package:train_away/widgets/navegation/top_banner.dart';
import 'package:train_away/navigation/reserva_reinicio.dart';
import 'package:train_away/core/configs/app_theme.dart';

// Inicia la aplicación Train Away.
void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ReservaModel()),
      ChangeNotifierProvider(create: (_) => LastTrainProvider()),
      ChangeNotifierProvider(
        create: (_) =>
            ReservasProvider(ReservationDatabase.instance)..chargeReservas(),
      ),
      ChangeNotifierProvider(create: (_) => ThemeProvider()..loadTheme()),
    ],
    child: const TrainAwayApp(),
  ),
);

final _router = GoRouter(
  initialLocation: '/reservar',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        final selectedPath = state.uri.path == '/ajustes'
            ? state.uri.queryParameters['place'] ?? '/reservar'
            : state.uri.path;

        return Scaffold(
          appBar: AppBanner(
            onLogoTap: () => reiniciarReserva(context),
            currentPath: selectedPath,
          ),
          body: child,
          bottomNavigationBar: BottomNavBar(currentPath: selectedPath),
        );
      },
      routes: [
        GoRoute(
          path: '/reservar',
          builder: (context, state) => FormPage(),
          routes: [
            GoRoute(path: 'fecha', builder: (context, state) => DateTimePage()),
            GoRoute(
              path: 'confirmacion',
              builder: (context, state) => ReservationConfirmedPage(),
            ),
          ],
        ),

        GoRoute(
          path: '/reserva-confirmada',
          builder: (context, state) => SuccessPage(),
        ),

        GoRoute(
          path: '/mis-reservas',
          builder: (context, state) => MisReservasPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => ReservaDetallePage(),
            ),
          ],
        ),

        GoRoute(path: '/ajustes', builder: (context, state) => SettingsPage()),
      ],
    ),
  ],
);

class TrainAwayApp extends StatelessWidget {
  const TrainAwayApp({super.key});

  // Widget de la aplicación
  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeProvider>().themeMode;
    return MaterialApp.router(
      title: 'Train Away',
      debugShowCheckedModeBanner: false,

      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,

      supportedLocales: const [Locale('en'), Locale('es')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate,
      ],
      themeMode: themeMode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
    );
  }
}
