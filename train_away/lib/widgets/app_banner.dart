import 'package:flutter/material.dart';

import 'package:train_away/theme/app_colors.dart';

class AppBanner extends StatelessWidget implements PreferredSizeWidget {
  const AppBanner({this.onLogoTap, super.key});

  final VoidCallback? onLogoTap;

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) => AppBar(
    toolbarHeight: 70,
    backgroundColor: AppColors.white,
    surfaceTintColor: AppColors.white,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: GestureDetector(
      onTap: onLogoTap ?? () => Navigator.of(context).popUntil((route) => route.isFirst),
      child: const Text(
        'Train Away',
        style: TextStyle(
          color: AppColors.burgundy,
          fontSize: 32,
          fontFamily: 'Corinthia',
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
        ),
      )
    ),
    
    actions: [
      IconButton(
        icon: const Icon(Icons.menu, size: 34, color: AppColors.navy),
        onPressed: () {},
      ),
    ],
    
    shape: const Border(
      bottom: BorderSide(color: AppColors.navy, width: 1.5),
    ),
  );
}
