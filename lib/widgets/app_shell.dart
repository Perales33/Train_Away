import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget{
  const AppShell({
    required this.location,
    required this.child,
    super.key
  });

  final String location;
  final Widget child;

  Widget build(BuildContext context) {
    final selectIndex = location.startsWith('/mis-reservas') ? 1 : 0;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectIndex,
        onDestinationSelected: (index) {
          if(index == 0) {
            context.go('/reservar');
          }
          else {
            context.go('/mis-reservas');
          }
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.train_outlined), 
            selectedIcon: Icon(Icons.train),
            label: 'Reservar'
          ),
          NavigationDestination(
            icon: Icon(Icons.confirmation_num_outlined),
            selectedIcon: Icon(Icons.confirmation_num), 
            label: 'Mis reservas'
          )
        ]
      ),
    );
  }
}