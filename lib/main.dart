import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:train_away/pages/mis_reservas_pages/mis_reservas_page.dart';
import 'package:train_away/pages/mis_reservas_pages/reserva_detalle_page.dart';

import 'package:train_away/models/reserva_model.dart';
import 'package:train_away/pages/reservar_pages/date_time_page.dart';
import 'package:train_away/pages/reservar_pages/reservation_confirmed.dart';
import 'package:train_away/pages/reservar_pages/success_page.dart';
import 'package:train_away/pages/reservar_pages/form_page.dart';
import 'package:train_away/providers/last_train_provider.dart';
import 'package:train_away/providers/reservas_provider.dart';
import 'package:train_away/theme/app_colors.dart';
import 'package:train_away/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:train_away/widgets/general/app_banner.dart';

// Inicia la aplicación Train Away.
void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ReservaModel()),
      ChangeNotifierProvider(create: (_) => LastTrainProvider()),
      /*
      ChangeNotifierProvider(
        create: (_) => ReservasProvider(ReservasDatabase.instance),
        ..changeReservas(),
      )*/
    ],
    child: const TrainAwayApp(),
  ),
);

final _router = GoRouter(
  initialLocation: '/reservar',
  routes: [
    // --- Sección 'Reservar' ---
    ShellRoute(
      builder: (context, state, child) => Scaffold(
        appBar: AppBanner(),
        body: child, 
        bottomNavigationBar: const BottomNavBar()
      ),
      routes: [
        GoRoute(
          path: '/reservar',
          builder: (context, state) => FormPage(),
          routes: [
            GoRoute(
              path: 'fecha',
              builder: (context, state) => DateTimePage(),
            ),
            GoRoute(
              path: 'confirmacion',
              builder: (context, state) => ReservationConfirmedPage(),
            ),
          ]
        ),
        
        GoRoute(
          path: '/reserva-confirmada',
          builder: (context, state) => SuccessPage(),
        ),
      ],
    ),

    // --- Sección 'Mis reservas' ---
    ShellRoute(
      builder: (context, state, child) => Scaffold(
        appBar: AppBanner(),
        body: child, 
        bottomNavigationBar: const BottomNavBar()
      ),
      routes: [
        GoRoute(
          path: '/mis-reservas',
          builder: (context, state) => MisReservasPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => ReservaDetallePage(),
            ),
          ]
        ),
        
      ],
    ),
  ],
);

class TrainAwayApp extends StatelessWidget {
  const TrainAwayApp({super.key});

  // Widget de la aplicación
  @override
  Widget build(BuildContext context) => MaterialApp.router(
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
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.navy,
        primary: AppColors.navy,
      ),
      fontFamily: 'DM Sans',
    ),
  );
}